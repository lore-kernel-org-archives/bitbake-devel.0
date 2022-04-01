Return-Path: <maksym.iliev@litmus.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F436C433EF
	for <webhook@archiver.kernel.org>; Fri,  1 Apr 2022 13:31:47 +0000 (UTC)
Subject: Bitbake fails to find a file in SSTATE_MIRROR even though it exists
To: bitbake-devel@lists.openembedded.org
From: "Maksym Iliev" <maksym.iliev@litmus.io>
X-Originating-Location: Scarborough, Ontario, CA (66.22.163.164)
X-Originating-Platform: Windows Chrome 99
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Fri, 01 Apr 2022 06:31:46 -0700
Message-ID: <B369.1648819906487355784.8tFf@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="X5oY4gUiv1SUbeZuLdvw"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 01 Apr 2022 13:31:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13562

--X5oY4gUiv1SUbeZuLdvw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I have an AWS S3 bucket setup to be an SSTATE_MIRROR. However, there is an =
occasional error happening where bitbake is not able to find a file that ac=
tually exists in that bucket. Here is an example of an error:

WARNING: gdk-pixbuf-2.40.0-r0 do_packagedata_setscene: Failed to fetch URL =
file://3a/83/sstate:gdk-pixbuf:corei7-64-poky-linux:2.40.0:r0:corei7-64:3:3=
a83036f92542f5385730d42c4ffdffcbbde2822d48f7f194ce4957d21906f7e_packagedata=
.tgz.siginfo;downloadfilename=3D3a/83/sstate:gdk-pixbuf:corei7-64-poky-linu=
x:2.40.0:r0:corei7-64:3:3a83036f92542f5385730d42c4ffdffcbbde2822d48f7f194ce=
4957d21906f7e_packagedata.tgz.siginfo , attempting MIRRORS if available
ERROR: gdk-pixbuf-2.40.0-r0 do_packagedata_setscene: Fetcher failure: Unabl=
e to find file file://3a/83/sstate:gdk-pixbuf:corei7-64-poky-linux:2.40.0:r=
0:corei7-64:3:3a83036f92542f5385730d42c4ffdffcbbde2822d48f7f194ce4957d21906=
f7e_packagedata.tgz.siginfo;downloadfilename=3D3a/83/sstate:gdk-pixbuf:core=
i7-64-poky-linux:2.40.0:r0:corei7-64:3:3a83036f92542f5385730d42c4ffdffcbbde=
2822d48f7f194ce4957d21906f7e_packagedata.tgz.siginfo anywhere. The paths th=
at were searched were:
   /srv/yocto/sstate-cache
   /srv/yocto/sstate-cache

The base_local.conf configuration for SSTATE_MIRROR is as below (bucket nam=
e hidden):

INHERIT +=3D "own-mirrors"
SOURCE_MIRROR_URL =3D " https://*mybucketname*.s3.amazonaws.com/ ( https://=
yocto-dl-cache.s3.amazonaws.com/ ) "

My question is what could possibly be causing this issue?

--X5oY4gUiv1SUbeZuLdvw
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<p>I have an AWS S3 bucket setup to be an SSTATE_MIRROR. However, there is =
an occasional error happening where bitbake is not able to find a file that=
 actually exists in that bucket. Here is an example of an error:</p>
<pre class=3D"c-mrkdwn__pre" style=3D"box-sizing: inherit; margin-top: 4px;=
 margin-bottom: 4px; padding: 8px; --saf-0: rgba(var(--sk_foreground_low,29=
,28,29),0.13); font-size: 12px; line-height: 1.50001; font-variant-ligature=
s: none; white-space: pre-wrap; word-break: normal; tab-size: 4; border: 1p=
x solid var(--saf-0); background: rgba(var(--sk_foreground_min,29,28,29),0.=
04); counter-reset: list-0 0 list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 l=
ist-6 0 list-7 0 list-8 0 list-9 0; color: #1d1c1d; font-family: Monaco, Me=
nlo, Consolas, 'Courier New', monospace !important;" data-stringify-type=3D=
"pre">WARNING: gdk-pixbuf-2.40.0-r0 do_packagedata_setscene: Failed to fetc=
h URL <a class=3D"c-link" style=3D"box-sizing: inherit; color: inherit;" ta=
bindex=3D"-1" href=3D"file://3a/83/sstate:gdk-pixbuf:corei7-64-poky-linux:2=
.40.0:r0:corei7-64:3:3a83036f92542f5385730d42c4ffdffcbbde2822d48f7f194ce495=
7d21906f7e_packagedata.tgz.siginfo;downloadfilename=3D3a/83/sstate:gdk-pixb=
uf:corei7-64-poky-linux:2.40.0:r0:corei7-64:3:3a83036f92542f5385730d42c4ffd=
ffcbbde2822d48f7f194ce4957d21906f7e_packagedata.tgz.siginfo" target=3D"_bla=
nk" rel=3D"noopener noreferrer" data-stringify-link=3D"file://3a/83/sstate:=
gdk-pixbuf:corei7-64-poky-linux:2.40.0:r0:corei7-64:3:3a83036f92542f5385730=
d42c4ffdffcbbde2822d48f7f194ce4957d21906f7e_packagedata.tgz.siginfo;downloa=
dfilename=3D3a/83/sstate:gdk-pixbuf:corei7-64-poky-linux:2.40.0:r0:corei7-6=
4:3:3a83036f92542f5385730d42c4ffdffcbbde2822d48f7f194ce4957d21906f7e_packag=
edata.tgz.siginfo" data-sk=3D"tooltip_parent" data-remove-tab-index=3D"true=
">file://3a/83/sstate:gdk-pixbuf:corei7-64-poky-linux:2.40.0:r0:corei7-64:3=
:3a83036f92542f5385730d42c4ffdffcbbde2822d48f7f194ce4957d21906f7e_packageda=
ta.tgz.siginfo;downloadfilename=3D3a/83/sstate:gdk-pixbuf:corei7-64-poky-li=
nux:2.40.0:r0:corei7-64:3:3a83036f92542f5385730d42c4ffdffcbbde2822d48f7f194=
ce4957d21906f7e_packagedata.tgz.siginfo</a>, attempting MIRRORS if availabl=
e
ERROR: gdk-pixbuf-2.40.0-r0 do_packagedata_setscene: Fetcher failure: Unabl=
e to find file <a class=3D"c-link" style=3D"box-sizing: inherit; color: inh=
erit; text-decoration-line: underline;" tabindex=3D"-1" href=3D"file://3a/8=
3/sstate:gdk-pixbuf:corei7-64-poky-linux:2.40.0:r0:corei7-64:3:3a83036f9254=
2f5385730d42c4ffdffcbbde2822d48f7f194ce4957d21906f7e_packagedata.tgz.siginf=
o;downloadfilename=3D3a/83/sstate:gdk-pixbuf:corei7-64-poky-linux:2.40.0:r0=
:corei7-64:3:3a83036f92542f5385730d42c4ffdffcbbde2822d48f7f194ce4957d21906f=
7e_packagedata.tgz.siginfo" target=3D"_blank" rel=3D"noopener noreferrer" d=
ata-stringify-link=3D"file://3a/83/sstate:gdk-pixbuf:corei7-64-poky-linux:2=
.40.0:r0:corei7-64:3:3a83036f92542f5385730d42c4ffdffcbbde2822d48f7f194ce495=
7d21906f7e_packagedata.tgz.siginfo;downloadfilename=3D3a/83/sstate:gdk-pixb=
uf:corei7-64-poky-linux:2.40.0:r0:corei7-64:3:3a83036f92542f5385730d42c4ffd=
ffcbbde2822d48f7f194ce4957d21906f7e_packagedata.tgz.siginfo" data-sk=3D"too=
ltip_parent" data-remove-tab-index=3D"true" aria-describedby=3D"sk-tooltip-=
30500">file://3a/83/sstate:gdk-pixbuf:corei7-64-poky-linux:2.40.0:r0:corei7=
-64:3:3a83036f92542f5385730d42c4ffdffcbbde2822d48f7f194ce4957d21906f7e_pack=
agedata.tgz.siginfo;downloadfilename=3D3a/83/sstate:gdk-pixbuf:corei7-64-po=
ky-linux:2.40.0:r0:corei7-64:3:3a83036f92542f5385730d42c4ffdffcbbde2822d48f=
7f194ce4957d21906f7e_packagedata.tgz.siginfo</a> anywhere. The paths that w=
ere searched were:
    /srv/yocto/sstate-cache
    /srv/yocto/sstate-cache</pre>
<p>The base_local.conf configuration for SSTATE_MIRROR is as below (bucket =
name hidden):</p>
<pre class=3D"c-mrkdwn__pre" style=3D"box-sizing: inherit; margin-top: 4px;=
 margin-bottom: 4px; padding: 8px; --saf-0: rgba(var(--sk_foreground_low,29=
,28,29),0.13); font-size: 12px; line-height: 1.50001; font-variant-ligature=
s: none; white-space: pre-wrap; word-break: normal; tab-size: 4; border: 1p=
x solid var(--saf-0); background: rgba(var(--sk_foreground_min,29,28,29),0.=
04); counter-reset: list-0 0 list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 l=
ist-6 0 list-7 0 list-8 0 list-9 0; color: #1d1c1d; font-family: Monaco, Me=
nlo, Consolas, 'Courier New', monospace !important;" data-stringify-type=3D=
"pre">INHERIT +=3D "own-mirrors"
SOURCE_MIRROR_URL =3D "<a class=3D"c-link" style=3D"box-sizing: inherit; co=
lor: inherit;" tabindex=3D"-1" href=3D"https://yocto-dl-cache.s3.amazonaws.=
com/" target=3D"_blank" rel=3D"noopener noreferrer" data-stringify-link=3D"=
https://yocto-dl-cache.s3.amazonaws.com/" data-sk=3D"tooltip_parent" data-r=
emove-tab-index=3D"true">https://*mybucketname*.s3.amazonaws.com/</a>"</pre=
>
<p>&nbsp;</p>
<p>My question is what could possibly be causing this issue?</p>

--X5oY4gUiv1SUbeZuLdvw--

