OmegaFold
=========

Raw install
-----------

```shell
conda deactivate 
conda remove -y -n omegafold --all

conda create -y -n omegafold python=3.10
conda activate omegafold
python setup.py install

# get the weights
cd ~/.cache/
wget https://helixon.s3.amazonaws.com/release1.pt
```


Docker Install
--------------

Check that you can access the GPUs from docker
```shell
docker run --runtime=nvidia --gpus all nvidia/cuda:12.3.1-base-ubuntu20.04 nvidia-smi
docker run --runtime=nvidia -it
```

Just use Docker...
```shell
docker build -t omegafold-gpu -f GPU.Dockerfile .
docker run -it --runtime=nvidia --gpus all omegafold-gpu /bin/bash
```

Test...
```sh
nvidia-smi
python -c 'import torch; print(torch.cuda.is_available())'
```


