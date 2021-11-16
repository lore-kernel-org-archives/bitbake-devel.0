Return-Path: <mohammedaqdam@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D54C433F5
	for <webhook@archiver.kernel.org>; Tue, 16 Nov 2021 06:02:55 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web12.6304.1637042574184422451
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Nov 2021 22:02:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=dVizGLDG;
 spf=pass (domain: gmail.com, ip: 209.85.221.53,
 mailfrom: mohammedaqdam@gmail.com)
Received: by mail-wr1-f53.google.com with SMTP id t30so35184935wra.10;
        Mon, 15 Nov 2021 22:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=a6s7JevlS90NqW1kj+13RqBwl8Fq7W1BE0fs0l9piAc=;
        b=dVizGLDGnVk8VNRlFK+LB6sLsBp7s5kmc9Njc9rmTu5a+rShgHjmEmJLngAQiH0/1d
         HyLL7GpDlqMprRNlLC/2IZnZ+8cH7Ua3j8JnwUhNbMv4mk7kPPQBxFltRgvgKYu0Hv+W
         qEDC2AtEFgmy7MvZkvNkNIgsm5PoYALjLgPW5OUU3MXPkeWCRRaNFRLKqQcTnkohhCF1
         8nM5Ee5QTLxyyGiSfS4b/7Gjre03HwnmXajO6/Ht9TYw0X9FyG7iClR/31TT9zmeDktb
         +Ld/QnnnsNQZPaXoRO2+5CalnRycuNUpZPLSoRhg8LWZvTYufxOTFJS2lBUeQ60G6sWX
         GkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=a6s7JevlS90NqW1kj+13RqBwl8Fq7W1BE0fs0l9piAc=;
        b=ThujtujW2Z3rqRgz4R0F+GWL2DiIlRNgj8i+fqeJW3FcQKRZ3PlQ2uyNngUOz073T5
         7l5oLSAGf0RBs9mC/usJwDkGX7bZFS4TWeDhE+WITjKDhtnk5VMcgNyno9FAnsdqlFGz
         LtrO8zM/cMKAGplYGb60b7rwGBk2pevN7hEeQO3WnFBNHSJIJSDPTuZeXfi+u0sNJNKJ
         0xqaMlI5XuhjjrxG8n6LS9eTk6mSdZVYrxlTXFsZeSNRy3Gka/EJJPv04Rm2es09iLc+
         T+KDKsp/wh5bFUmmVOr5fe0QYlMwzy7020obVkbBV2QRs+n/9uMH5O1sYGZMCyWLV3cr
         ZAeA==
X-Gm-Message-State: AOAM531/TcuIUORFsXGwtE1Pnvb4JXiv48rf/ZhkRRl07XIbWb03Qsv8
	OO3Q7yPeTCElYs0t7fe90voXidtoG78vxA8QKDUrSiyxzTE=
X-Google-Smtp-Source: 
 ABdhPJw/xjYqUql0oDIg9OBfAVJl+967zR89pBWNx1BCUnH+Gmx7Qe5QjeonRr/iZdKPZJj739+hKHvNzuKv4Y3ARZk=
X-Received: by 2002:a5d:6dc1:: with SMTP id d1mr1026031wrz.282.1637042572559;
 Mon, 15 Nov 2021 22:02:52 -0800 (PST)
MIME-Version: 1.0
From: mohammed aqdam <mohammedaqdam@gmail.com>
Date: Tue, 16 Nov 2021 11:32:41 +0530
Message-ID: 
 <CAGsrAHdBHjCn5Onwczj12UHAbsHm_tdh1FKdY_g7kq_W=3VGPw@mail.gmail.com>
Subject: Use of FSL_EULA_FILE_MD5SUMS_append with latest bitbake(master)
To: bitbake-devel@lists.openembedded.org,
	bitbake-devel+help@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000050c4705d0e1ad03"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Nov 2021 06:02:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13057

--000000000000050c4705d0e1ad03
Content-Type: text/plain; charset="UTF-8"

Hi There,

I am working on a yocto image for the imx8 board, for this I have created a
project with zeus layers for all layers(including meta-imx) using the below
manifest file.

repo init -u https://source.codeaurora.org/external/imx/imx-manifest -b
imx-linux-zeus -m imx-5.4.47-2.2.0.xml


I am trying to fetch master/honister code of openEmbedded on my
existing project(Earlier i was using Zeus branch) to use latest modules of
perl(5.34.0), chrony(4.1) & gpsd(gpsd 3.23.1
<http://layers.openembedded.org/layerindex/recipe/1120/>), by modifying
.repo/manifests/imx-5.4.47-2.2.0.xml with master/honister code for
openEmbedded(revision="refs/heads/honister"), later i ran into below error,

$ bitbake -k imx-image-full
ERROR: Unable to start bitbake server (None)
ERROR: Server log for this session
(/data/home/maqdam/imx_yocto_master/build/bitbake-cookerdaemon.log):
--- Starting bitbake server pid 6315 at 2021-11-16 10:36:44.095759 ---
ERROR: ParseError at
/data/home/maqdam/imx_yocto_master/sources/meta-openembedded/meta-oe/conf/layer.conf:106:
unparsed line: 'DEFAULT_TEST_SUITES:pn-meta-oe-ptest-image = "
${PTESTTESTSUITE}"'


Tried updating the bitbake layer(poky) to master/honister in
similar fashion, Later seeing the below error in
meta-imx/meta-bsp/conf/layer.conf file.

$ bitbake -k imx-image-full
ERROR: Variable FSL_EULA_FILE_MD5SUMS_append contains an operation using
the old override syntax. Please convert this layer/metadata before
attempting to use with a newer bitbake.


I could not find how to use FSL_EULA_FILE_MD5SUMS_append with the latest
bitbake manual.
Request you to suggest what syntax change i have to make for
FSL_EULA_FILE_MD5SUMS_append
in order to make it work with latest bitbake(master/honister)

Thanks,
Aqdam

--000000000000050c4705d0e1ad03
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-family:arial,sans-serif">Hi There,</sp=
an><br><font face=3D"arial, sans-serif"><br></font><span style=3D"font-fami=
ly:arial,sans-serif">I am working on a yocto image for the imx8 board, for =
this I have created a project with zeus layers for all layers(including met=
a-imx) using the below manifest file.</span><br><blockquote style=3D"margin=
:0px 0px 0px 40px;border:none;padding:0px"><font face=3D"arial, sans-serif"=
><code style=3D"border-radius:0px;background-image:none;background-position=
:initial;background-size:initial;background-repeat:initial;background-origi=
n:initial;background-clip:initial;border:0px;float:none;height:auto;line-he=
ight:20px;margin:0px;outline:0px;overflow:visible;padding:0px;vertical-alig=
n:baseline;width:auto;box-sizing:content-box;font-size:14px;min-height:inhe=
rit;white-space:nowrap;color:rgb(0,0,0)">repo init -u https:</code><code st=
yle=3D"border-radius:0px;background-image:none;background-position:initial;=
background-size:initial;background-repeat:initial;background-origin:initial=
;background-clip:initial;border:0px;float:none;height:auto;line-height:20px=
;margin:0px;outline:0px;overflow:visible;padding:0px;vertical-align:baselin=
e;width:auto;box-sizing:content-box;font-size:14px;min-height:inherit;white=
-space:nowrap;color:rgb(0,0,0)">//source</code><code style=3D"border-radius=
:0px;background-image:none;background-position:initial;background-size:init=
ial;background-repeat:initial;background-origin:initial;background-clip:ini=
tial;border:0px;float:none;height:auto;line-height:20px;margin:0px;outline:=
0px;overflow:visible;padding:0px;vertical-align:baseline;width:auto;box-siz=
ing:content-box;font-size:14px;min-height:inherit;white-space:nowrap;color:=
rgb(0,0,0)">.<a href=3D"http://codeaurora.org/" target=3D"_blank">codeauror=
a.org</a></code><code style=3D"border-radius:0px;background-image:none;back=
ground-position:initial;background-size:initial;background-repeat:initial;b=
ackground-origin:initial;background-clip:initial;border:0px;float:none;heig=
ht:auto;line-height:20px;margin:0px;outline:0px;overflow:visible;padding:0p=
x;vertical-align:baseline;width:auto;box-sizing:content-box;font-size:14px;=
min-height:inherit;white-space:nowrap;color:rgb(0,0,0)">/external/imx/imx-m=
anifest</code><span style=3D"color:rgb(51,51,51);font-size:14px;white-space=
:nowrap">=C2=A0</span><code style=3D"border-radius:0px;background-image:non=
e;background-position:initial;background-size:initial;background-repeat:ini=
tial;background-origin:initial;background-clip:initial;border:0px;float:non=
e;height:auto;line-height:20px;margin:0px;outline:0px;overflow:visible;padd=
ing:0px;vertical-align:baseline;width:auto;box-sizing:content-box;font-size=
:14px;min-height:inherit;white-space:nowrap;color:rgb(0,0,0)">-b imx-linux-=
zeus -m imx-5.4.47-2.2.0.xml</code></font></blockquote><font face=3D"arial,=
 sans-serif"><br></font><span style=3D"font-family:arial,sans-serif">I am t=
rying to fetch master/</span><span style=3D"font-family:arial,sans-serif;co=
lor:rgb(51,51,51);font-size:14px">honister</span><span style=3D"font-family=
:arial,sans-serif;color:rgb(51,51,51);font-size:14px">=C2=A0code of openEmb=
edded on my existing=C2=A0project(Earlier i was using Zeus branch) to use l=
atest modules of perl(</span><span style=3D"font-family:arial,sans-serif;co=
lor:rgb(51,51,51);font-size:14px">5.34.0)</span><span style=3D"font-family:=
arial,sans-serif;color:rgb(51,51,51);font-size:14px">,=C2=A0</span><span st=
yle=3D"font-family:arial,sans-serif;color:rgb(51,51,51);font-size:14px">chr=
ony(4.1)</span><span style=3D"font-family:arial,sans-serif;color:rgb(51,51,=
51);font-size:14px">=C2=A0&amp; gpsd(</span><a href=3D"http://layers.openem=
bedded.org/layerindex/recipe/1120/" target=3D"_blank" style=3D"color:rgb(51=
,122,183);font-family:arial,sans-serif;box-sizing:border-box;text-decoratio=
n-line:none;font-size:14px">gpsd 3.23.1</a><span style=3D"font-family:arial=
,sans-serif">)</span><font color=3D"#333333" style=3D"font-family:arial,san=
s-serif"><span style=3D"font-size:14px">, by modifying .repo/manifests/</sp=
an></font><span style=3D"font-family:arial,sans-serif;color:rgb(0,0,0);font=
-size:14px;white-space:nowrap">imx-5.4.47-2.2.0.xml</span><span style=3D"fo=
nt-family:arial,sans-serif">=C2=A0with master/</span><span style=3D"font-fa=
mily:arial,sans-serif;color:rgb(51,51,51);font-size:14px">honister code for=
=C2=A0</span><span style=3D"font-family:arial,sans-serif;color:rgb(51,51,51=
);font-size:14px">openEmbedded(</span>revision=3D&quot;refs/heads/honister&=
quot;<span style=3D"font-family:arial,sans-serif;color:rgb(51,51,51);font-s=
ize:14px">), later</span><span style=3D"font-family:arial,sans-serif">=C2=
=A0i ran into below error,</span><br><font face=3D"arial, sans-serif"><br><=
/font><blockquote style=3D"margin:0px 0px 0px 40px;border:none;padding:0px"=
><div><div><font face=3D"arial, sans-serif">$ bitbake -k imx-image-full</fo=
nt></div></div><div><div><font face=3D"arial, sans-serif">ERROR: Unable to =
start bitbake server (None)</font></div></div><div><div><font face=3D"arial=
, sans-serif">ERROR: Server log for this session (/data/home/maqdam/imx_yoc=
to_master/build/bitbake-cookerdaemon.log):</font></div></div><div><div><fon=
t face=3D"arial, sans-serif">--- Starting bitbake server pid 6315 at 2021-1=
1-16 10:36:44.095759 ---</font></div></div><div><div><font face=3D"arial, s=
ans-serif">ERROR: ParseError at /data/home/maqdam/imx_yocto_master/sources/=
meta-openembedded/meta-oe/conf/layer.conf:106: unparsed line: &#39;DEFAULT_=
TEST_SUITES:pn-meta-oe-ptest-image =3D &quot; ${PTESTTESTSUITE}&quot;&#39;<=
/font></div></div></blockquote><span style=3D"font-family:arial,sans-serif"=
>=C2=A0</span><br><span style=3D"font-family:arial,sans-serif">Tried updati=
ng the bitbake layer(poky) to master/honister in similar=C2=A0fashion, Late=
r seeing the below error in meta-imx/meta-bsp/conf/layer.conf file.</span><=
br><blockquote style=3D"margin:0px 0px 0px 40px;border:none;padding:0px"><f=
ont face=3D"arial, sans-serif">$ bitbake -k imx-image-full<br></font><font =
face=3D"arial, sans-serif">ERROR: Variable FSL_EULA_FILE_MD5SUMS_append con=
tains an operation using the old override syntax. Please convert this layer=
/metadata before attempting to use with a newer bitbake.</font></blockquote=
><font face=3D"arial, sans-serif"><br></font><span style=3D"font-family:ari=
al,sans-serif">I could not find how to use FSL_EULA_FILE_MD5SUMS_append wit=
h the latest bitbake manual.</span><br><span style=3D"font-family:arial,san=
s-serif">Request you to suggest what syntax change i have to make for=C2=A0=
</span>

<span style=3D"font-family:arial,sans-serif">FSL_EULA_FILE_MD5SUMS_append i=
n order to make it work with latest bitbake(m</span><span style=3D"font-fam=
ily:arial,sans-serif">aster/</span><span style=3D"font-family:arial,sans-se=
rif;color:rgb(51,51,51);font-size:14px">honister)</span><br><font color=3D"=
#333333" face=3D"arial, sans-serif"><span style=3D"font-size:14px"><br></sp=
an></font><span style=3D"font-family:arial,sans-serif;color:rgb(51,51,51);f=
ont-size:14px">Thanks,</span><br><span style=3D"font-family:arial,sans-seri=
f;color:rgb(51,51,51);font-size:14px">Aqdam</span><br></div>

--000000000000050c4705d0e1ad03--

