Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f43.google.com (mail-wg0-f43.google.com [74.125.82.43])
	by mail.openembedded.org (Postfix) with ESMTP id 641B773FD4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 May 2015 11:00:22 +0000 (UTC)
Received: by wgiu9 with SMTP id u9so124373032wgi.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 May 2015 04:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=ULZOvJW/6qx4aBwP0H+gp/Z3p/xSn71vBEB59ZJfpw4=;
	b=T0PdL9CDsrm3j21KVQj8YuFvx+MmLnAIxH6+y8SJb3Q44UjbQMyQL5Fzafb//HMGl5
	sL7EjIuuIOrc20VNS3sNGlWY60R7EI6zV3Cidv6ze78PLRTV5qN9ddt83us5DkDq9uZD
	yDbspvwCwfEtldEH4k3f/GrsHfsI+6RblmHBLC9oWtl2sa2BqOrpPKpXe8BID8/ZTORY
	VMZixLl95jK2gVwcLuVp4SSpxkf4NuWj2hLTv9yKpUTaIvzDYJsCCcbYFx0wxkIeZfj9
	hErD833xVKEs0UplrByFF9ijAE4fgobGXOcJjQcDl7BHiLLTYdObfGKPJyXMM+Rn6cjv
	4klg==
X-Gm-Message-State: ALoCoQmo/t9QgTaUjdGewQpBsgLIu6r4t7aXBg5Y8oBukX+pWlfOQwKIKGhOwWrAQrkWiwFbDH0p
X-Received: by 10.180.218.195 with SMTP id pi3mr18542400wic.71.1431342023565; 
	Mon, 11 May 2015 04:00:23 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	vy5sm19272580wjc.33.2015.05.11.04.00.22
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 11 May 2015 04:00:22 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id F1FE05605D9; Mon, 11 May 2015 11:58:42 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 11 May 2015 11:58:40 +0100
Message-Id: <b66d4ec3e6d5b682e6cf533b151748f632f9f3bc.1431338029.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <7ffd7ba923c85a735e0dad528f1ab9d50073724b.1431338029.git.alexandru.damian@intel.com>
References: <7ffd7ba923c85a735e0dad528f1ab9d50073724b.1431338029.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1431338029.git.alexandru.damian@intel.com>
References: <cover.1431338029.git.alexandru.damian@intel.com>
Subject: [PATCH 09/11] toaster: adding art missing from Bootstrap
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 11 May 2015 11:00:24 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

When Bootstrap 2.3 was imported, we missed a couple of art file.

This patch adds them to complete Bootstrap integrity.

License used is (as previously documented).

GLYPHICONS Halflings released with Bootstrap, CC BY 3.0

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 .../static/img/glyphicons-halflings-white.png           | Bin 0 -> 8777 bytes
 .../toastergui/static/img/glyphicons-halflings.png      | Bin 0 -> 12799 bytes
 2 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 lib/toaster/toastergui/static/img/glyphicons-halflings-white.png
 create mode 100644 lib/toaster/toastergui/static/img/glyphicons-halflings.png

diff --git a/lib/toaster/toastergui/static/img/glyphicons-halflings-white.png b/lib/toaster/toastergui/static/img/glyphicons-halflings-white.png
new file mode 100644
index 0000000000000000000000000000000000000000..3bf6484a29d8da269f9bc874b25493a45fae3bae
GIT binary patch
literal 8777
zcmZvC1yGz#v+m*$LXcp=A$ZWB0fL7wNbp_U*$~{_gL`my3oP#L!5tQYy99Ta`+g_q
zKlj|KJ2f@c)ARJx{q*b<Rc{fZDE|-E3z8Qg5C}{9v!pTzga8NZOmrk*O`5892Z0dh
z6y;PuJwHDK9$?(w-u|_L_3`o1($W%e0`}kWUyy&dCnqOQPfu4@SAgf?;o*P$z|s8t
zJh1KR>bkhN_!|Wn*Vos8{TEhUT@5e;_WJsIMMcG5%>DiS&dv_N`4@J0cnAQ-#>RjZ
z00W5t&tJ^l-QC*ST1-p~00u^9XJ=AUl7oW-;2a+x2k__T=grN{+1c4XK0ZL~^z^i$
zp&>vEhr@4fZWb380S18T&!0cQ3IKpHF)?v=b_NIm0Q>v<fKgXh*W25>wY7D0baZ)n
z31Fa5sELUQARIVaU0nqf0XzT+fB_63aA;@<$l~wse|mcA;^G1TmX?-)e)jkGPfkuA
z92@|!<>h5S_4f8QP-JRq>d&7)^Yin8l7K8gED$&_FaV?gY+wLjpoW%~7NDe=nHfMG
z5DO3j{R9kv5GbssrUpO)<pElNvVjx;Inad7%}rnn)BtoiIXM{s0C>Oyv<s*i2m!7M
zNCXUk1jq|?5|99_k&%%AIlu-a0ty3=KxY8j%*;&S3IIajE_Qc!f%*X_5DScgf&xH0
zumu>Vrlx>u0UKD0i;Dpm5S5dY16(DL5l{ixz|mhJU@&-OWCTb7_%}8-fE(P~+XIRO
zJU|wp1|S>|J3KrLcz^+v1f&BDpd>&MAaibR4#5A_4(MucZwG9E1h4@u0P@C8;oo+g
zIVj7kfJi{oV~E(NZ*h(@^<JQ`7oGGHtP>-(Q(C`Psb3KZ{N;^GB(a8NE*Vwc715!9
zr-H4Ao|T_c6+VT_JH9H+P3>iXSt!a$F`>s`jn`w9GZ_~B!{<w2b}Uz=xRP0Noee!5
zHGxHKH;uZjouChSB9)ldcOm@{14~ct04{b8>0soaiV|O_c^R2aWa%}O3jUE)WO=pa
zs~_Wz08z|ieY5A%$@FcBF9^!1a}m5ks@7gjn;67N>}S~Hrm`4sM5Hh`q7&5-N{|31
z6x1{ol7Bn<k_m&K*9NkB7ANp6;_WSmra!UL^eY+pz_w5LlB(g$UY9|-AP@zsw4|7-
zi|#>skoViZ<brlX21G1wL@^v%v2P&MSTZc8SKT&&Tq!~%Uw%k^(D<O<S;ewoH)@(b
zb2Z<#wBV6y-?HHFVJFRg^me&@Reg!dys6F1>0GqbLa#kW`Z<Hy>)VCjt1MysKg|rT
zi!?s#<KsBd5lg=VLu4^|xo0%enAx0mMXMSpk0KF_*gOS;jx!zP=@5TPN+S>#Ck>8c
zpi|>$lGlw#@yMNi&V4`6OBGJ(H&7lqLlcTQ&1zWriG_fL>BnFcr~?;E93{M-xIozQ
zO=EHQ#+?<}%@wbWWv23#!V70h9MOuUVaU>3kpTvYfc|LBw?&b*89~Gc9i&8tlT#kF
ztpbZoAzkdB+UTy=tx%L3Z4)I{zY(Kb)eg{InobSJmNwPZt$14aS-uc4eKuY<?xyi!
z`TeGpun(kP^7#~<fX0r^ExRQwveWDF;DOQbL}?LBzt>8h$dtfyxu^a%zA)<y|4;I#
zFU8x7%0eT|Hd@3!T6Anh3IoHrN%@H8e6ge;3u)_$N2H&Rv2`ml6;kL~xS07C5Nzt<
z>>fYI&)@ZXky?^{5>xSC?;w4r&td6vBdi%vHm4=XJH!3yL3?Ep+T5aU_>i;yr_XGq
zxZfCzUU@GvnoIk+_Nd`aky>S&H!b*{A%L>?*XPAgWL(Vf(k7qUS}>Zn=U(ZfcOc{B
z3*tOHH@t5Ub5D~#N7!Fxx}P2)sy{vE_l(R7$aW&CX>c|&HY+7};vUIietK%}!ph<X
z*_6&Ee=)&D@nDa!y{$f<(Q`UdM+|H2ksGEhG7utFYl`Y6pD#+4LC8Hw@6|1H-x{D`
zE$uaNS!i^Rx(%B(My5}1#H73>rCuh+;C@1usp;XLU<8Gq8P!rEI3<U)y>ieg#W$!=
zQcZr{hp>8sF?k&Yl0?B84OneiQxef-4TEFrq3O~JAZR}yEJHA|Xkqd49tR&8oq{zP
zY@>J^HBV*(gJvJZc_0VFN7Sx?H7#75E3#?N8<p*btH>Z!C+_f53YU}py<FUNWgSuj
zi^M}p>ggxx1?wQi5Yb-_`I`_V*SMx5+*P^b=ec5RON-k1cIlsBLk}(HiaJyab0`CI
zo0{<v3Q5P3@oM!6@v&t6RJy0OS}M??mGqk1x;(pa`FWA#n+2z37<uPHl{#HvB!^?r
zm9?WOv;Tt(gt*?Pw;;%nF3|I0gDBXPM>=1_LO$~oE2%Tl_}KURuX<`+mQN_sTdM&*
zkFf!Xtl^e^gTy6ON=&gTn6)$JHQq2)33R@_!#9?BLNq-Wi{U|rVX7Vny$l6#+S<va
z%-r+y8D)Cm{5=IM8|<{prj)kZfIZ$NiW0)fE9{-SR)@-;NBJtHk@DI_v*mK(N0#s#
z?S8~jyotdcJJAAUt_;Tr)fa|*cT)~*JZ!c_7yVpSb{r2MllfJDbfI~-7n_#K6lw4G
z^Eyhsh^z8eZs2;adrfk9ip%h;IP|>Z@KvQt@VYb%<9JfapI^b9j=wa+Tqb4ei;8c5
z&1>Uz@lVFv6T4Z*YU$r4G`g=91lSeA<=GRZ!*KTWKDPR}NPUW%peCUj`Ix_LDq!8|
zMH-V`Pv!a~QkTL||L@cqiTz)*G-0=ytr1KqTuFPan9y4gYD5>PleK`NZB$ev@W%t=
zkp)_=lBUTLZJpAtZg;pjI;7r2y|26-N7&a(h<zryrg`J^oeC|8V|qszB+|*eQ-(Dy
zbn*nJ1W|b4-1y?dTI6}3IPMw+-O0;Q@eMMtjjQ+G6QfN3ae61Yd9LfQx_UREWecK4
zMn7A~fOz)be1)Yg{2Ysl9G%s8-h-~@C;ALAL0r=<JP2uCe!T|wAywH1r;F|f_q8N(
zYp^0FkyL9uj<8bK@fyTtgo+DT)14B^<SigcSJotgDV02O!M(CS6_B&^bILwyV?Ng4
zm7WQp?{l<Obhuy=22?5<oQDiM22&u4rZrRVG|L9ABfY{=95aTyd~@a$o~1P#ji`=w
zBKmQqX}r3Nlk9Q|gR7)~#n6AzYk`#!R*d5x`A)hU(!1R1%^zXxNJ(kPCw4htU9^(O
zP4cYV^F(I>X|`1YNM9N8{>8JAu<en5+94bD>v}hp1v`3JHT-=5lbXpbMq7X~2J5Kl
zh7tyU`_AusMFZ{ej9D;Uyy;SQ!4nwgSnngsYBwdS&EO3NS*o04)*j<g2BLf;iAZ2(
z7Key$cc6ey>uAYl;57c2Ly0(DEZ8IY?zSph-kyxu+D`tt@oU{32J#I{vmy=#0ySPK
zA+i(A3yl)qmTz*$dZi#y9FS;$;h%bY+;StNx{_R56Otq+?pGe^T^{5d7Gs&?`_r`8
zD&dzOA|j8@3<oPyCd}SOX6AZj_;pT>A&FR5U3*eQNBf<4^4W_iS_()*8b4aaUzfk2
zzIcMWSEjm;EPZPk{j{1>oXd}pXAj!NaRm8{Sjz!D=~q3WJ@vmt6ND_?HI~|wUS1j5
z9!S1MKr7%nxoJ3k`GB^7yV~*{n~O~n6($~x5Bu{7s|JyXbAyKI4+tO(zZYMslK;Zc
zzeHGVl{`iP@jfSKq>R;{+djJ9n%$%EL()Uw+sykjNQdflkJZSjqV_QDWivbZS~S{K
zkE@T^Jcv)Dfm93!mf$XYnCT--_A$zo9MOkPB6&diM8MwOfV?+ApNv`moV@nqn>&lv
zYbN1-M|jc~sG|yLN^1R2=`+1ih3jCshg`iP&mY$GMTcY^W^T`WOCX!{-KHmZ#GiRH
zYl{|+KLn5!PCLtBy~9i}`#d^gCDDx$+GQb~uc;V#K3OgbbOG0j5{BRG-si%Bo{@lB
zGIt+Ain8^C`!*S0d0OSWVO+Z8<kqm;qPrHIJ!qB8;9h5*>9}}O8aFTZ>p&k}2gGCV
zh#<$gswePFxWGT$4DC^8@84_e*^KT74?7n8!$8cg=sL$OlKr&HMh@Rr5%*Wr!xoOl
zo7jItnj-xYgVTX)H1=A2bD(tle<tL7^Z!nJ*fwgn&QUe>EH57#V{xAeW_ezISg5OC
zg=k>hOLA^urTH_e6*vSYRqCm$J{xo}-x3@HH;bsHD1Z`Pzvsn}%cvfw%Q(}h`Dgtb
z0_J^niUmoCM5$*f)6}}qi(u;cPgxfyeV<wtcQgsqG?QDyA@6XXM7siU#+0#mP~AnX
z9f=bMes~9>aaVmOsG<)5`6tzU4wyhF;k|~|x>7-2hXpVBpc5k{L4M`Wbe6Q?tr^*B
z`Y*>6*&R#~%JlBIitlZ^qGe3s21~h3U|&k%%jeMM;6!~UH|+0+<5V-_zDqZQN7<fD
zM2vP&&BMr(%$M51tLpycNES^{gnGn-o~t&>9?n?!Aj!Nj`YMO9?j>uqI9-Tex+nJD
z%e0#Yca6(zqGUR|KITa?9x-#C0!JKJHO(+fy@1!B$%ZwJwncQW7vGYv?~!^`#L~Um
zOL++>4qmqW`0Chc0T23G8|vO)tK=Z2`gvS4*qpqhIJCEv9i&&$09VO8YOz|oZ+ubd
zNXVdLc&p=KsSgtmIPLN69P7xYkYQ1vJ?u1g)T!6Ru`k2wkdj*wDC)VryGu2=yb0?F
z>q~~e>KZ0d<sP$M^)hrN7IC)eGuv*?pAk#*4fxII<8rIx545@9E}-};{IJdo*}!V1
zkUgWQp<TD%7(QQhWkf*vd;SiT1P@}N?jaoKEV?lzqfa1pG1Y^}ikjNMM*Kb?m5(n&
zOz8{+G2z7JatI<J95R%#%#ATAzlwPl$?6)w6WH~ku?(FhO)k1eRlF4I5UqR?T`Iy=
z_bVtkxqs3lQGny-BS%nkzwrXhI_M|P4l_VNVoMjVRoZ*0(JkMQ#AdJLFBj%$oTBx9
z_5|g_ll0@cfLf<j;&lJ>_#7f3UgV%9MY1}vMgF{B8yfE{HL*pMyhYF)WDZ^^3vS8F
zGlOhs%g_~pS3=WQ#494@jAXwOtr^Y|TnQ5zki>qRG)(oPY*f}U_=ip_{qB0!%w7~G
zWE!P4p3khyW-JJnE>eECuYfI?^d366Shq!Wm#x&jA<tFBO~aWRutYg|6S!-V%dvXb
zjpm3-7^fYCzbWmx*ts$8ECu=f{D#|=T{2_Q?C-SVQTSi8ey{G^D$8U&*bY{vQ$kGG
zq$8)>o>=HdCllE$>DPO0N;y#4G)D2y#B@5=N=+F%Xo2n{gKcPcK2!hP*^WSXl+ut;
zyLvVoY>VL{H%Kd9^i~lsb8j4>$EllrparEOJNT?Ym>vJa$(P^tOG)5aVb_5w^*&M0
zYOJ`I`}<NkH4X@iCc57jNSqY3D>9}UoSnYg#E(&yyK(tqr^@n}qU2H2DhkK-`2He%
zgXr_4kpXoQHxAO9S`wEdmqGU4j=1JdG!OixdqB4PPP6<nq;ZS)73s_@N{54U_<mt#
zR{@UUroZJ1=lVB~3y%RbLLE=9Mh=pj4wNruVxXLk8pKH)JVr{Hbx`P1XQ>RXA}>GM
zumruUUH|ZG2$bBj)Qluj&uB=dRb)?^qomw?Z$X%#D+Q*O97eHrgVB2*mR$bFBU`*}
zIem?dM)i}raTFDn@5^caxE^XFXVhBePmH9fqcTi`TLaXiueH=@06sl}>F%}h9H_e9
z>^O?LxM1EjX}NVppaO@NNQr=AtHcH-BU{yBT_vejJ#J)l^cl69Z7$sk`82Zyw7Wxt
z=~J?hZm{f@W}|96FUJfy65Gk8?^{^yjhOahUMCNNpt5DJw}ZKH7b!bGiFY9y6OY&T
z_N)?Jj(MuLTN36ZCJ6<obtKS{VOOSzs>I5Xy7uVlrb$o*Z%=-)kPo9s?<^Yqz~!Z*
z_mP<Y8YDC3(vm~>8(unFq65XSi!$@YtieSQ!<7IEOaA9VkKI?lA`*(nURv<D`3vIl
zzk?RMHDq|}aqs!Q7n{<V(L>fKL8cX}-+~uw9|_5)uC2`ZHca<BJSyCJ7L7R3^ezpJ
zixdU%^Arizo-zh;Lga89_J>eX7L8aG6Ghleg@F9aG%X$#g6^yP5apnB>YTz&EfS{q
z9UVfSyEIczebC)qlVu5cOoMzS_jrC|)rQlAzK7sfiW0`M8mVIohazPE9Jzn*qPt%6
zZL8RELY@L09B83@Be;x5V-IHnn$}{RAT#<2JA%ttlk#^(%u}CGze|1JY5MPhbfnYG
zIw%$XfBmA-<_pKLpGKwbRF$#P;@_)ech#>vj25sv25VM$ouo)?BXdRcO{)*OwTw)G
zv43W~T6ekBMtUD%5Bm>`<n0ehww;K9t*_z=^iZoM2Gjm6Wx6QTWDzOX28g|i7p-G(
znPo(pGb2-Hja^(5g>^Ltv!w4~65N!Ut5twl!Agrzyq4O2Fi3pUMtCU~>9gt_=h-f%
z;1&OuSu?A_sJvIvQ+dZNo3?m1%b1+s&UAx?8sUHEe_sB7zkm4R%6)<@oYB_i5>3Ip
zIA+?jVdX|zL{)?TGpx+=Ta>G80}0}Ax+722$XFNJsC1gcH56{8B)*)eU#r~HrC&}`
z|EWW92&;6y;3}!L5zXa385@?-D%>dSvyK;?jqU2t_R3wvBW;$!j45uQ7tyEIQv<v(
zw)qBpyRhiKBMR9HV)v2ZJdk>a;Db}r&bR3kqNSh)Q_$MJ#Uj3Gj1F;)sO|%6z#@<+
zi{pbYsYS#u`X$Nf($OS+lhw>xgjos1OnF^$-I$u;qhJswhH~p|ab*nO>zBrtb0ndn
zxV0uh!LN`&xckTP+JW}gznSpU492)u+`f{9Yr)js`NmfYH#Wdtradc0TnKNz@Su!e
zu$9}G_=ku;%4xk}eXl>)KgpuT>_<`Ud(A^a++K&pm3LbN;gI}ku@YVrA%FJBZ5$;m
zobR8}OLtW4-i+qPPLS-(7<>M{)rhiPoi@?&vDeVq5%fmZk=mDdRV>Pb-l7pP1y6|J
z8I>sF+TypKV=_<SBxSgNFy@5`t70+_4F<*(g54PNEt&4u%OoVR^n+$TL)qKdP6c)n
z-CoP*_kXZ4vBsj8M^2Y0nDq-^4r-wgu2Y-3fmi6ooPIXTI%UdJhw@7KgR=N+Vl3NO
zcl8-&i~^e%3E1G+u&^#M&5!sI)la$uQ2y&KsaZjx^r8D68BTZd^NrAV{0u$=#SH#4
zLE2)q%<UADH&I$um|>^NwBU^>4JJq<*14GLfM2*XQzYdlqqjnE)gZsPW^E@mp&ww*
zW9i>XL=uwLVZ9pO*8K>t>vdL~Ek_NUL$?LQi5sc#1Q-f6-ywKcIT8Kw?C<o*=Aa~-
z*eA0Mgmu5-j8rTh^;={1$#X=Ck5Gk;@KK#haYa^sXr0^_^Q84%+WOl3?#Mc#{{d}B
z>(_3pbR`e|)%9S-({if|E+hR2W!&qfQ&UiF^I!|M#xhdWsen<tq75@@WHX{+T3S~F
znoMw2v{^ia4`fkd=3p<6XkL)!lsI%8iq@>v^wpKCBiuxXbnp85`{i|;BM?Ba`lqTA
zyRm=UWJl&E{8JzYDHFu>*Z10-?#A8D|5jW9Ho0*CAs0fAy~MqbwYuOq9jjt9*nuHI
zbDwKvh)5Ir$r!fS5|;?Dt>V+@F*v8=TJJF)TdnC#Mk>+tGDGCw;A~^PC`gUt*<(|i
zB{{g{`uFehu`$fm4)&k7`u{xIV)yvA(%5SxX9MS80p2EKnL<HSdiWFiAy=3UmV-rj
zc%^|o`X!t!vuYErrUzbG?ostY(qs7GE^=Z33k*P+F6r($h_?W-bHJ|GUK@Wlv9++M
zG}?Z?8{_X${_c9aOXw4qfk0vTaVRH6FMOnFD?w|zo{zKKg$8wzW&yufWk&idB=+9!
z^dTI@g=>t<HJ%Cd%{u~X`lRpMFg&X{m?Nw#T4cg*?z{+rC($M4z9RHV@8KoueD7_)
z8T@i-6RG$5%_Y`lSjj|?wSvITK5c4g0!Uq49VAn-H<9~;vn7~hBdYuDOt2$gtNuBm
zo8$Y{2lwMxZNbfb$Hm0T528Og7Jfl!35edSr>CZ>tlX>*Z6nd&6-<c}7z{sZ9V^Ux
zMNgR3$iH97>Mv$5rHD*<Fmux@1NkgiA%VmyOAwal{&*L*?*@Cl?&!jtcf3KL{{|8z
z_($$R;SoAei#gUO@=7)M7s~2aAxJ>db;&IBK3KH&M<+ArlGXDRdX1VVO4)&R$f4<g
z`M~bg9+=(|cc^a3vB10?3GZiq$o|Zromh?lE2%m!alG4CIrvmRZHZVSM>NxXI>GBh
zSv|h>5GDAI(4E`@F?En<q4iBUtn-fux#Jt=qU6#PBE4-GhP)}OK!CI;i(sJ6^VIJF
zwJMEAeGKMb_^`VbA1hFYio)roSCrLG-NL5Yqhb{sh3_zt(Zg93UP*;!m?}k&V`1AB
zNYPri&yVkXW8uO1geXM3Oj&$G%~#Jd%h;?JDKwrq;P+!t&4W1Z^1?Ikguvk#bK?Bx
z$w5M*LxgRe=jz?UiDBbfC1I3!cjeMD*ueh4W0S*z6=TAf+ZYkG$}FGti`ipjpIK>W
zS>#c&Gw6~_XL`qQG4bK`W*>hek4LX*efn6|_MY+rXkNyAuu?NxS%L7~9tD3cn7&p(
zCtfqe6sjB&Q-Vs7BP5+%;#Gk};4xtwU!KY0XXbmkUy$kR9)!~?*v)qw00!+Yg^#H>
zc#8*z6zZo>+(bud?K<*!QO<vKd$8TBt^HLIw%iB>4ehiTCK&PD4G&n)Tr9X_3r-we
z?fI+}-G~Yn93gI6F{}Dw_SC*FLZ)5(85zp4%uubtD)J)UELLkvGk4#tw&Tuss<g@J
zd3(n+h;=s-joD7pea}*kl|?T5<3W!rK}V)#HpvFL3uRc{oe_mV<z1l~^m1_TkJDu3
z;JtNs6#g&&@E09TG{#Z`zh|EKwRTiJr)s50$5?Nrhn68HAr=rV#m>a)mTD$R2&O~{
zCI3>fr-!-b@EGRI%g0L8UU%%u_<;e9439JNV;4KSxd|78v+I+8^rmM<g+mx0&Si$a
zgf1uYC03KcCN)Lz!>f3f40Jb}wEszROD?xBZu>Ll3;sUIoNxDK3|j3*sam2tC@@e$
z^!;+AK>efeBJB%ALsQ{uFui)oD<x}JL&L^@dTz{b&_?*nsS;lNnoJ@(k9d5xVq$|w
z<ejC>oq()2USi?n=6C3#eetz?wPswc={I<8x=(8lE4EIsUfyGNZ{|KYn1IR|=E==f
z(;!A5(-2y^2xRFCSPqzHAZn5RCN_bp22T(KEtjA(rFZ%>a4@STrHZflxKoqe9Z4@^
zM*scx_y73<sFS1_?6+u!sT9fvjld*kU~edMy>?Q{<Kw(x)TAd1JfBpLz7(Nk)Jsdz
zj7#eyM{0^=a(C#N_pwZ(&^&zZP@5Qw`oUBRW0i<S2ql<0tEs~>vt6?~WEl?2q*;@8
z3M*&@%l)SQmXkcUm)d@GT2#JdzhfSAP9|n#C;$E8X|pwD!r#X?0P>0ZisQ~TNqupW
z*lUY~+ikD`vQb?@SAWX#r*Y+;=_|oacL$2CL$^(mV}aKO77pg}O+-=T1oLBT5sL2i
z42Qth<Jh0Ysw=K%u7GarF`3bIM1>2+0@C`c+*D0*5!qy26sis<9a7>LN2{z%Qj49t
z=L@x`4$ALHb*3COHoT?5S_c(Hs}g!V>W^=6Q0}zaubkDn)(lTax0+!+%B}9Vqw6{H
zvL|BRM`O<@;eVi1DzM!tXtBrA20Ce@^Jz|>%X-t`vi-%WweXCh_LhI#bUg2*pcP~R
z*RuTUzBKLXO~~uMd&o$v3@d0shHfUjC6c539PE6rF&;Ufa(Rw@K1*m7?f5)t`MjH0
z)_V(cajV5Am>f!kWcI@5rE8t6$S>5M=k=aRZROH6fA^jJp~2NlR4;Q2>L$7F#RT#9
z>4@1RhWG`Khy>P2j1Yx^BBL{S`niMaxlSWV-JBU0-T9zZ%>7mR3l$~QV$({o0;jTI
ze5=cN^!Bc2bT|BcojXp~K#2cM>OTe*cM{Kg-j*CkiW)EGQot^}s;cy8_1_@JA0Whq
zlrNr+R;Efa+`6N)s5rH*|E)nYZ3uqkk2C(E7@A|3YI`ozP~9Lexx#*1(r8luq+YPk
z{J}c$<WQa$CfVIhsE>s`<i2`cEPYHzF!ZIy?L$}MhAPFqQe@_8Lh#cQAH~-zZ5p$u
zZauEKr<oluR2T6z2A|B^#roi2jr3F<X4&!ZjiXo?9nIbJ4iAii=A_@&#n$TqH^#R&
z{$qMQO7u^&7KEB6l{H~A;ylPsJw2kA4#E2@7dO%lsi+3{VJ4?~e4(Bz-tw&^YR9P1
zTlpCH(W_%+@#|?%RN0HM=U?pU5$E2f<RPK1fw%3KLs--hd|lj})1h|Y<6CA3NsuSI
zl=<<g*vcJW=6yZY`aXe5QUB~awgg5fxlu%7u#A8=UXt61U-7wGtR{L&XvKbUf-}PL
z<eXA6<<r^;=`XwtFN1~2J^$Y${#Q0Tyev?j!*Z4q^mjQ4ah)uW_s=JkrRS%l*Ut`>
zPM35Fx(YWB3Z5IYnN+L_4|jaR(5iWJi2~l&xy}aU7kW?o-V*6Av2wyZTG!E2KSW2*
zGRLQkQU;Oz##ie-Z4fI)WSRxn$(ZcD;TL+;^r=a4(G~H3ZhK$lSXZj?cvyY8%d9JM
zzc3#pD^W_QnWy#rx#;<pgDoauRid_B6w$J6XKKeAcZHU9rH9=s!y`%~e@hGc<c#A7
zRRTR`&dt`*;~VYcVGk-~aNB!?q#4B&%52?dI@=%LQ>c&N@sqHhrnHRmj<I9Tx4aSD
zVUQ}9lh=Kd&QIx0uCqYm3pFs_*L;b|$xyZks(AAwgYsH85PAL~ndH7DNUoZKBHCWu
z_<;@&ed^tpoO=DG4Hem|2>#i;s%zLm6SE(n&BWpd&f7>XnjV}OlZntI70fq%8~9<7
zMYaw`E-rp49-oC1N_uZTo)Cu%RR2QWdHpzQIcNsoDp`3xfP+`gI?tVQZ4X={qU?(n
zV>0ASES^Xuc;9JBji{)RnFL(Lez;8XbB1uWaMp@p?7xhXk6V#!6B@aP4Rz7-K%a>i
z?fvf}va_DGUXlI#4--`A3qK7J?-HwnG7O~H2;zR~RLW)_^#La!=}+>KW#anZ{|^D3
B7G?kd

literal 0
HcmV?d00001

diff --git a/lib/toaster/toastergui/static/img/glyphicons-halflings.png b/lib/toaster/toastergui/static/img/glyphicons-halflings.png
new file mode 100644
index 0000000000000000000000000000000000000000..a9969993201f9cee63cf9f49217646347297b643
GIT binary patch
literal 12799
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

literal 0
HcmV?d00001

-- 
1.9.1


