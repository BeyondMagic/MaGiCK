#!/usr/bin/env sh
#
# João F. © BeyondMagic 2022 <koetemagie@gmail.com>

fg_time_date_special='#222222'
fg_time_date_last_part='#111111'

# Last part.
lp="<span color='$fg_time_date_last_part'>%a%d</span>"

# Separator Type.
st="<span color='$fg_time_date_special'>:</span>"

date +"%H$st%M$st%S$lp"
