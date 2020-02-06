# 2D_registration
registration of time-lapse imaging data

<img src="doc/demo.gif" width="800" align="below">


You can Choose fro 2 methods (fast method and precise method) according to your image data property.

Image_registration_fast is fast method but normal precision and only adapted to translation move.

Image_registration_precise is precise and adapted to rigid move (translation and rotation) but takes much time and you must set the range of searching.

Image_registration_fastは、高速なレジストをおこなうコード(精度は普通、回転には対応していない)

Image_registration_preciseは、範囲を指定して、範囲内で精密なレジストをおこなうコード(時間がかかる)


## Dependencies
MATLAB

Image Processing Toolbox

(optional) Parallel Computing Toolbox (for GPU use only)


## Author
Takehiro Ajioka 

E-mail:1790651m@stu.kobe-u.ac.jp

## Affiliation

Division of System Neuroscience, Kobe University of Graduate School of Medicine

神戸大学医学研究科システム生理学分野
