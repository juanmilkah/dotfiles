while true; do
  BAT0=$(cat /sys/class/power_supply/BAT0/capacity);
  BAT1=$(cat /sys/class/power_supply/BAT1/capacity);

  AVG=$(((BAT0+BAT1)/2));

  echo $AVG > ~/battery/capacity;

  sleep 3;
  
done
