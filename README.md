# sprint-ias

Modelos de IA abertos que o painel do Sprint baixa para o computador do lojista (plano Pro).
Rodam no aparelho do lojista: nenhuma IA pela internet.

| Arquivo | O que é | Licença |
|---|---|---|
| isnet-v2.onnx.000 … .008 | ISNet general-use (recorte de fundo), em 9 pedaços de 19 MB. Igual ao original, só com MaxPool ceil_mode=0 (mesmo resultado na entrada 1024; a placa de vídeo do navegador aceita). isnet.onnx.* é a versão antiga, pode apagar | Apache 2.0 — https://github.com/xuebinqin/DIS (cópia de https://github.com/danielgatis/rembg) |
| upscale-x4.onnx | Real-ESRGAN realesr-general-x4v3 (aumentar qualidade), convertido para ONNX | BSD 3-Clause — https://github.com/xinntao/Real-ESRGAN |

O motor (onnxruntime-web 1.22.0, MIT) vem do jsDelivr.
Publicar: dois cliques em PUBLICAR-IAS.bat (cria o repositório PÚBLICO noveusprintapp/sprint-ias e a versão v1).
Não coloque aqui nada da loja, chave ou dado de cliente: este repositório é público.
