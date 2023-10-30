# Interface 2023年12月号 別冊付録1 サンプルコード
「[Interface 2023年12月号 別冊付録1 ](https://interface.cqpub.co.jp/magazine/202312/) 7000円ボードで始める FPGA開発 Vol.3」の「カメラとモニタのリアルタイム制御」で使用したサンプルコードです。

すぐに使用できるように [Release] に .fs 形式のファイルをおいてあります。

# [Tang Nano 4K で動作するカメラ・システム](./camera_hdmi-for-TangNano-4K)
第１章　カメラとモニタを使うシステムの全体像、第２章　カメラのRAWデータからカラー画像をを作るで
使用した Tang Nano 4K で動作するカメラ・システムです。Bayer のデコーダ・モジュールが入っています。
オリジナルは [https://github.com/sipeed/TangNano-4K-example] にあります。

# [第３章 高位合成でコードをわかりやすくする](./I2C)
Polyphony でコンパイル可能な Python のコードです。

# [第４章 Tang Primer 20K で画像の輪郭検出](./OV5640_LCD480_DDR3-for-TangPrimer-20K)
Tang Primer 20K で動作するカメラ + LCD のシステムです。輪郭抽出のモジュールが入っています。
オリジナル [https://github.com/sipeed/TangPrimer-20K-example] にあります。