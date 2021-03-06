SynthDef.new(\marimba,
{|vib=0, bus=0, slide=0, rate=1, sus=1, slidefrom=1, fmod=0, amp=1, freq=0, bits=0, pan=0|
var osc, env;
freq = freq + fmod;
freq = Line.ar(freq * slidefrom, freq * (1 + slide), sus);
freq = Vibrato.kr(freq, rate: vib);
osc=Klank.ar(`[[0.5, 1, 4, 9], [0.5, 1, 1, 1], [1, 1, 1, 1]], PinkNoise.ar([0.007, 0.007]), [freq, freq], [0, 2]);
sus=1;
env=EnvGen.ar(Env.perc(level: amp,curve: -6,attackTime: 0.001,releaseTime: sus), doneAction: 0);
osc=(osc * env);
osc = osc * [min(1, (1-pan)/2), min(1, (pan+1)/2)];
	ReplaceOut.ar(bus, osc)}).add;
