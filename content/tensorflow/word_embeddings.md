---
title: "워드 임베딩"
date: 2020-02-22T13:05:55+03:00
draft: true
---

https://www.tensorflow.org/tutorials/text/word_embeddings

[![img](https://www.tensorflow.org/images/colab_logo_32px.png)Run in Google Colab](https://colab.research.google.com/github/tensorflow/docs/blob/master/site/en/tutorials/text/word_embeddings.ipynb)  [![img](https://www.tensorflow.org/images/GitHub-Mark-32px.png)View source on GitHub](https://github.com/tensorflow/docs/blob/master/site/en/tutorials/text/word_embeddings.ipynb)  [![img](https://www.tensorflow.org/images/download_logo_32px.png)Download notebook](https://storage.googleapis.com/tensorflow_docs/docs/site/en/tutorials/text/word_embeddings.ipynb) 

본 문서는 워드 임베딩을 소개하는 튜토리얼입니다. It contains complete code to train word embeddings from scratch on a small dataset, and to visualize these embeddings using the [Embedding Projector](http://projector.tensorflow.org/) (shown in the image below).

![Screenshot of the embedding projector](http://github.com/tensorflow/docs/blob/master/site/en/tutorials/text/images/embedding.jpg?raw=1)

### 텍스트를 숫자로 나타내기

머신 러닝 모델이 텍스트를 처리하려면, 문자열을 벡터로 만들어 모델로 전달(feeding)해야 합니다. 이를 위한 세가지 전략을 소개합니다.

원-핫 인코딩

첫번째 전략으로 "원-핫" 인코딩은 어휘의 각 단어를 인코드합니다. "The cat sat on the mat"라는 문장을 문장이 있다고 합시다. 문장내 어휘 (or 유니크 단어)는 (cat, mat, on, sat, the)입니다. 각 단어를 표현하기 위해, 어휘 수 만큼의 zero 벡터를 만듭니다. 그리고 단어에 대응하는 인덱스를 둡니다.

![Diagram of one-hot encodings](http://github.com/tensorflow/docs/blob/master/site/en/tutorials/text/images/one-hot.png?raw=1)

문장의 인코딩을 포함하는 벡터를 생성하기 위해, 각 워드에 대한 one-hot 벡터를 결합합니다. 이 방법은 sparse representation한 바법으로 비효율적입니다. 인덱스 외에 99.99%가 zero 요소이기 때문입니다.

### Encode each word with a unique number

두번째 접근은 유일한 숫자로 할당하는 방식으로 접근하는 것 입니다. 예제를 살펴봅시다. cat은 1로 할당하고 mat은 2로 할당합니다. 이와 같은 방식으로 할당합니다. "The cat sat on the mat"를 인코딩 하면 [5, 1, 4, 3, 5, 2]와 같은 dense vector를 만들 수 있습니다. 이 방식은 효율적입니다.

두가지 불리한 면(downsides)이 있습니다.

- integer-encoding은 임의적임(단어간에 관계를 알 수 없음).
- An integer-encoding can be challenging for a model to interpret. A linear classifier, for example, learns a single weight for each feature. Because there is no relationship between the similarity of any two words and the similarity of their encodings, this feature-weight combination is not meaningful.

### 워드 임베딩

워드 임베딩은 효율적인 방법입니다. dense representation in which similar words have a similar encoding. Importantly, we do not have to specify this encoding by hand. An embedding is a dense vector of floating point values (the length of the vector is a parameter you specify). Instead of specifying the values for the embedding manually, they are trainable parameters (weights learned by the model during training, in the same way a model learns weights for a dense layer). It is common to see word embeddings that are 8-dimensional (for small datasets), up to 1024-dimensions when working with large datasets. A higher dimensional embedding can capture fine-grained relationships between words, but takes more data to learn.

![Diagram of an embedding](http://github.com/tensorflow/docs/blob/master/site/en/tutorials/text/images/embedding2.png?raw=1)

Above is a diagram for a word embedding. Each word is represented as a 4-dimensional vector of floating point values. Another way to think of an embedding is as "lookup table". After these weights have been learned, we can encode each word by looking up the dense vector it corresponds to in the table.

### Setup

```python
from __future__ import absolute_import, division, print_function, unicode_literals

try:
  # %tensorflow_version only exists in Colab.
  !pip install -q tf-nightly
except Exception:
  pass
import tensorflow as tf
ERROR: tensorflow 2.1.0 has requirement gast==0.2.2, but you'll have gast 0.3.3 which is incompatible.
from tensorflow import keras
from tensorflow.keras import layers

import tensorflow_datasets as tfds
tfds.disable_progress_bar()
```

### Using the Embedding layer

Keras makes it easy to use word embeddings. Let's take a look at the [Embedding](https://www.tensorflow.org/api_docs/python/tf/keras/layers/Embedding) layer.

The **Embedding laye**r can be understood as a lookup table that maps from integer indices (which stand for specific words) to dense vectors (their embeddings). The dimensionality (or width) of the embedding is a parameter you can experiment with to see what works well for your problem, much in the same way you would experiment with the number of neurons in a Dense layer.

```python
embedding_layer = layers.Embedding(1000, 5)
```

When you create an Embedding layer, the weights for the embedding are randomly initialized (just like any other layer). During training, they are gradually adjusted via backpropagation. Once trained, the learned word embeddings will roughly encode similarities between words (as they were learned for the specific problem your model is trained on).

If you pass an integer to an embedding layer, the result replaces each integer with the vector from the embedding table:

```python
result = embedding_layer(tf.constant([1,2,3]))
result.numpy()
array([[-0.03594022, -0.03196182, -0.04941077,  0.02727597, -0.03828459],
       [ 0.01020286,  0.02121068,  0.02133181,  0.01950819, -0.0070258 ],
       [ 0.01116052,  0.02467798,  0.00412848,  0.03739857, -0.04404547]],
      dtype=float32)
```

For text or sequence problems, the Embedding layer takes a 2D tensor of integers, of shape `(samples, sequence_length)`, where each entry is a sequence of integers. It can embed sequences of variable lengths. You could feed into the embedding layer above batches with shapes `(32, 10)` (batch of 32 sequences of length 10) or `(64, 15)` (batch of 64 sequences of length 15).

The returned tensor has one more axis than the input, the embedding vectors are aligned along the new last axis. Pass it a `(2, 3)` input batch and the output is `(2, 3, N)`

```python
result = embedding_layer(tf.constant([[0,1,2],[3,4,5]]))
result.shape
TensorShape([2, 3, 5])
```

When given a batch of sequences as input, an embedding layer returns a 3D floating point tensor, of shape `(samples, sequence_length, embedding_dimensionality)`. To convert from this sequence of variable length to a fixed representation there are a variety of standard approaches. You could use an RNN, Attention, or pooling layer before passing it to a Dense layer. This tutorial uses pooling because it's simplest. The [Text Classification with an RNN](https://www.tensorflow.org/tutorials/text/text_classification_rnn) tutorial is a good next step.

### Learning embeddings from scratch

In this tutorial you will train a sentiment classifier on IMDB movie reviews. In the process, the model will learn embeddings from scratch. We will use to a preprocessed dataset.

To load a text dataset from scratch see the [Loading text tutorial](https://www.tensorflow.org/tutorials/load_data/text).

```python
(train_data, test_data), info = tfds.load(
    'imdb_reviews/subwords8k', 
    split = (tfds.Split.TRAIN, tfds.Split.TEST), 
    with_info=True, as_supervised=True)
```

Get the encoder ([`tfds.features.text.SubwordTextEncoder`](https://www.tensorflow.org/datasets/api_docs/python/tfds/features/text/SubwordTextEncoder)), and have a quick look at the vocabulary.

The "_" in the vocabulary represent spaces. Note how the vocabulary includes whole words (ending with "_") and partial words which it can use to build larger words:

```python
encoder = info.features['text'].encoder
encoder.subwords[:20]
['the_',
 ', ',
 '. ',
 'a_',
 'and_',
 'of_',
 'to_',
 's_',
 'is_',
 'br',
 'in_',
 'I_',
 'that_',
 'this_',
 'it_',
 ' /><',
 ' />',
 'was_',
 'The_',
 'as_']
```

Movie reviews can be different lengths. We will use the `padded_batch` method to standardize the lengths of the reviews.

```python
train_batches = train_data.shuffle(1000).padded_batch(10)
test_batches = test_data.shuffle(1000).padded_batch(10)
```

As imported, the text of reviews is integer-encoded (each integer represents a specific word or word-part in the vocabulary).

Note the trailing zeros, because the batch is padded to the longest example.

```python
train_batch, train_labels = next(iter(train_batches))
train_batch.numpy()
array([[ 387,  712,    5, ...,    0,    0,    0],
       [ 518, 1693,  192, ...,    0,    0,    0],
       [8002, 7968,  123, ...,    0,    0,    0],
       ...,
       [  62,   27,  140, ...,    0,    0,    0],
       [  12,   31,  674, ...,    0,    0,    0],
       [  62,    9,    4, ...,    0,    0,    0]])
```

### Create a simple model

We will use the [Keras Sequential API](https://www.tensorflow.org/guide/keras) to define our model. In this case it is a "Continuous bag of words" style model.

- Next the Embedding layer takes the integer-encoded vocabulary and looks up the embedding vector for each word-index. These vectors are learned as the model trains. The vectors add a dimension to the output array. The resulting dimensions are: `(batch, sequence, embedding)`.
- Next, a GlobalAveragePooling1D layer returns a fixed-length output vector for each example by averaging over the sequence dimension. This allows the model to handle input of variable length, in the simplest way possible.
- This fixed-length output vector is piped through a fully-connected (Dense) layer with 16 hidden units.
- The last layer is densely connected with a single output node. Using the sigmoid activation function, this value is a float between 0 and 1, representing a probability (or confidence level) that the review is positive.

**Caution:** This model doesn't use masking, so the zero-padding is used as part of the input, so the padding length may affect the output. To fix this, see the [masking and padding guide](https://www.tensorflow.org/guide/keras/masking_and_padding).

```python
embedding_dim=16

model = keras.Sequential([
  layers.Embedding(encoder.vocab_size, embedding_dim),
  layers.GlobalAveragePooling1D(),
  layers.Dense(16, activation='relu'),
  layers.Dense(1)
])

model.summary()
Model: "sequential"
_________________________________________________________________
Layer (type)                 Output Shape              Param #   
=================================================================
embedding_1 (Embedding)      (None, None, 16)          130960    
_________________________________________________________________
global_average_pooling1d (Gl (None, 16)                0         
_________________________________________________________________
dense (Dense)                (None, 16)                272       
_________________________________________________________________
dense_1 (Dense)              (None, 1)                 17        
=================================================================
Total params: 131,249
Trainable params: 131,249
Non-trainable params: 0
_________________________________________________________________
```

Compile and train the model

```python
model.compile(optimizer='adam',
              loss=tf.keras.losses.BinaryCrossentropy(from_logits=True),
              metrics=['accuracy'])

history = model.fit(
    train_batches,
    epochs=10,
    validation_data=test_batches, validation_steps=20)
Train for 2500 steps, validate for 20 steps
Epoch 1/10
2500/2500 [==============================] - 12s 5ms/step - loss: 0.5060 - accuracy: 0.6986 - val_loss: 0.3832 - val_accuracy: 0.7700
Epoch 2/10
2500/2500 [==============================] - 11s 4ms/step - loss: 0.2816 - accuracy: 0.8839 - val_loss: 0.3455 - val_accuracy: 0.8050
Epoch 3/10
2500/2500 [==============================] - 11s 4ms/step - loss: 0.2261 - accuracy: 0.9115 - val_loss: 0.4650 - val_accuracy: 0.8300
Epoch 4/10
2500/2500 [==============================] - 11s 4ms/step - loss: 0.1937 - accuracy: 0.9265 - val_loss: 0.2923 - val_accuracy: 0.8950
Epoch 5/10
2500/2500 [==============================] - 11s 5ms/step - loss: 0.1718 - accuracy: 0.9359 - val_loss: 0.4552 - val_accuracy: 0.8750
Epoch 6/10
2500/2500 [==============================] - 11s 4ms/step - loss: 0.1552 - accuracy: 0.9433 - val_loss: 0.5299 - val_accuracy: 0.8300
Epoch 7/10
2500/2500 [==============================] - 11s 4ms/step - loss: 0.1411 - accuracy: 0.9478 - val_loss: 0.3705 - val_accuracy: 0.8700
Epoch 8/10
2500/2500 [==============================] - 11s 4ms/step - loss: 0.1291 - accuracy: 0.9545 - val_loss: 0.5628 - val_accuracy: 0.8300
Epoch 9/10
2500/2500 [==============================] - 11s 4ms/step - loss: 0.1186 - accuracy: 0.9575 - val_loss: 0.3554 - val_accuracy: 0.8850
Epoch 10/10
2500/2500 [==============================] - 12s 5ms/step - loss: 0.1077 - accuracy: 0.9636 - val_loss: 0.5951 - val_accuracy: 0.8550
```

With this approach our model reaches a validation accuracy of around 88% (note the model is overfitting, training accuracy is significantly higher).

```python
import matplotlib.pyplot as plt

history_dict = history.history

acc = history_dict['accuracy']
val_acc = history_dict['val_accuracy']
loss=history_dict['loss']
val_loss=history_dict['val_loss']

epochs = range(1, len(acc) + 1)

plt.figure(figsize=(12,9))
plt.plot(epochs, loss, 'bo', label='Training loss')
plt.plot(epochs, val_loss, 'b', label='Validation loss')
plt.title('Training and validation loss')
plt.xlabel('Epochs')
plt.ylabel('Loss')
plt.legend()
plt.show()

plt.figure(figsize=(12,9))
plt.plot(epochs, acc, 'bo', label='Training acc')
plt.plot(epochs, val_acc, 'b', label='Validation acc')
plt.title('Training and validation accuracy')
plt.xlabel('Epochs')
plt.ylabel('Accuracy')
plt.legend(loc='lower right')
plt.ylim((0.5,1))
plt.show()
```

![png](https://www.tensorflow.org/tutorials/text/word_embeddings_files/output_0D3OTmOT1z1O_0.png)

![png](https://www.tensorflow.org/tutorials/text/word_embeddings_files/output_0D3OTmOT1z1O_1.png)

### Retrieve the learned embeddings

Next, let's retrieve the word embeddings learned during training. This will be a matrix of shape `(vocab_size, embedding-dimension)`.

```python
e = model.layers[0]
weights = e.get_weights()[0]
print(weights.shape) # shape: (vocab_size, embedding_dim)
(8185, 16)
```

We will now write the weights to disk. To use the [Embedding Projector](http://projector.tensorflow.org/), we will upload two files in tab separated format: a file of vectors (containing the embedding), and a file of meta data (containing the words).

```python
import io

encoder = info.features['text'].encoder

out_v = io.open('vecs.tsv', 'w', encoding='utf-8')
out_m = io.open('meta.tsv', 'w', encoding='utf-8')

for num, word in enumerate(encoder.subwords):
  vec = weights[num+1] # skip 0, it's padding.
  out_m.write(word + "\n")
  out_v.write('\t'.join([str(x) for x in vec]) + "\n")
out_v.close()
out_m.close()
```

If you are running this tutorial in [Colaboratory](https://colab.research.google.com/), you can use the following snippet to download these files to your local machine (or use the file browser, *View -> Table of contents -> File browser*).

```python
try:
  from google.colab import files
except ImportError:
   pass
else:
  files.download('vecs.tsv')
  files.download('meta.tsv')
```

### Visualize the embeddings

To visualize our embeddings we will upload them to the embedding projector.

Open the [Embedding Projector](http://projector.tensorflow.org/) (this can also run in a local TensorBoard instance).

- Click on "Load data".
- Upload the two files we created above: `vecs.tsv` and `meta.tsv`.

The embeddings you have trained will now be displayed. You can search for words to find their closest neighbors. For example, try searching for "beautiful". You may see neighbors like "wonderful".

**Note:** your results may be a bit different, depending on how weights were randomly initialized before training the embedding layer.

**Note:** experimentally, you may be able to produce more interpretable embeddings by using a simpler model. Try deleting the `Dense(16)` layer, retraining the model, and visualizing the embeddings again.

![Screenshot of the embedding projector](http://github.com/tensorflow/docs/blob/master/site/en/tutorials/text/images/embedding.jpg?raw=1)

### Next steps

This tutorial has shown you how to train and visualize word embeddings from scratch on a small dataset.

- To learn about recurrent networks see the [Keras RNN Guide](https://www.tensorflow.org/guide/keras/rnn).
- To learn more about text classification (including the overall workflow, and if you're curious about when to use embeddings vs one-hot encodings) we recommend this practical text classification [guide](https://developers.google.com/machine-learning/guides/text-classification/step-2-5).