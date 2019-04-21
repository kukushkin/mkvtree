# What is MKVTree and how it works

A MKVTree is a variation of a Merkle tree []() with key-value properties. It serves a purpose of
presenting a set of commitments as a single hash value, where each individual commitment
is a key-value pair.

A **key** is a bit array of some fixed length.

A **value** is a hash of some data the commitment commits to.

> For the practical purposes of this library we choose **key** size to be 256 bits long
> and the hash function for **leaf** and inner **node** values to be SHA256.

MKVTree is a binary tree structure, where each **leaf** is a **value** corresponding to some **key**, and the **key** represents
a path in that tree. The depth of the tree corresponds to the size of the **key**.

A **node** value (which is everything except the **leaf** nodes)
is a hash of concatenated values of its left and right sub-nodes.

The **root node**'s value is called a **root hash** and it corresponds to the set of all individual **leaf** values combined.

[Picture of a full MKVTree]

## Principal properties of the MKVTree

* It is possible to provide proof that a certain **key-value** pair is included in the given **root hash**
* It is possible to provide proof that a certain **key** has no value associated with it in the given **root hash**
* The proof provided for a given **key-value** pair exposes no information on other **value**s ??? [NOTE: only true for non-empty keys]

## Calculating a path from the given key

[Picture of the path in an MKVTree]

## Null values

A **key** which has no value associated with it is considered to have
a special *null* value.

A *null* value is a SHA256 hash of an empty string (0 bytes long):
```
```

## Constructing a MKVTree

The following order of operations should be considered when constructing a MKVTree:

* create an empty MKVTree
* for a *key1* with *value1*, insert a leaf with given value
* repeat for all other non-empty keys
* calculate the root hash (and all the inner nodes)

When calculating the root hash it is important to note, that for
any node it is known whether its left or right subtree is empty.
Any empty subtree is identical to another subtree of equal depth, so
it's possible to precompute the root hash values for empty sub-trees of any depth and cut the computation early.


## Proofs

A **proof** in a MKVTree is a proof that a given **value** is associated with the given **key** in a tree with a given **root hash**.

Given that a prover and a verifier agree on a certain **root hash**,
it is possible for a prover to provide a **proof** that can be used to independently verify, that the **root hash** contains certain **value** under certain **key**.

In short, a **proof** is a path in the MKTree which corresponds to the *key* together with all the node (and their sibling) hashes along this path.

[Picture of a path/proof MKVTree]


## Test vectors

[Link empty tree root hash]

[Link example 1 root hash]

[Link example 1 proof inclusion]

[Link example 1 proof exclusion]

## API


