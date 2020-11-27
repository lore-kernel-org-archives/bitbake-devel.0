Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
 by mx.groups.io with SMTP id smtpd.web08.18969.1606485298933639604
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Nov 2020 05:54:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=bMN1ipRk;
 spf=pass (domain: gmail.com, ip: 209.85.208.65, mailfrom: martin.jansa@gmail.com)
Received: by mail-ed1-f65.google.com with SMTP id a15so5820021edy.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 27 Nov 2020 05:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H/Ts8HkSyhMRsXJUvNmAQ5CWVPtrJVlroDMg+8Wp4uE=;
        b=bMN1ipRkRN3O2qtEkEw21UiNsgWufJDC3cCyc1DRag2CkHwDS6/HbhP9P/IgsjK2Ag
         LbsSGl0sxlnksM8nJmAT1I9zaRaPR+5mQ6gc6NtGurbyCbGqEVryACPMtrehh20/bxoO
         r5dpduUq3tKQSA+O8u/SRnDHkODsCrKdQmWxfzBVksX24EeFInJLoF2ORBYsNaM9xXPK
         E2MKOtOcxI2/B/x4Yc6R2rhsqBhGuUN6T+RvfHKnPUuTHHZx08ztd3nBH9+RnKUTSPor
         iYQUdgmji5i0hAIPgOF5A4EphCbZlAFHgtqLOI5YIJGlgyousAX6qiLhmb7R1pw0zCsW
         kppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H/Ts8HkSyhMRsXJUvNmAQ5CWVPtrJVlroDMg+8Wp4uE=;
        b=k3/4ou9Wocqrcd/GqkYT2YlQMZhYyZ/KAp9UBj2Uia3XakuIa//Ay+uNLsbZgTDdZh
         L2HJqTAGPHRmuE7gM54f+8XiLNeR6uwBt2YEQ0I16n4AOsUW7dYlFEnnjp71nxO8h/37
         mqmXchQ8D55b28k7arAzdbbTjbQeE0MmE3SicVihTpYn1uAwKp8D27bdPyIY/oVXVryA
         q6cufE7cazNAPxdd4Jwr+/G1APmX6ipPNAZL2nHAJIpRbPRfaYWBDjhFc3GJRotencOd
         7uGhbt18Q8KQ55GosfS1akNPp8jL+BWS2xycmB5C6A/vGy2ylMYfMDnFPXTv6CLRVm71
         bVkg==
X-Gm-Message-State: AOAM531DiMMjyMrzn9FSdq2ln2oegVniGXZhMEJDnkpyfYyunj/JQw5i
	U8TDSwyp0nMF2/qwnD1f6XzVnIYvPdOH2Q1L7kg=
X-Google-Smtp-Source: ABdhPJwJb5qbye3fIl+ztdcBotJ3vwsLlTrbmlD7Z2l9w1wIVOA6NetQvdUlzN7BRKnRwGf/Pl3VKNG5Jun0h9QSwV8=
X-Received: by 2002:a50:e882:: with SMTP id f2mr6744085edn.76.1606485297236;
 Fri, 27 Nov 2020 05:54:57 -0800 (PST)
MIME-Version: 1.0
References: <20201118153613.811-1-Cedric_Hombourger@mentor.com>
In-Reply-To: <20201118153613.811-1-Cedric_Hombourger@mentor.com>
From: "Martin Jansa" <Martin.Jansa@gmail.com>
Date: Fri, 27 Nov 2020 14:54:45 +0100
Message-ID: <CA+chaQez30Xyf-e+PDMOa5G-Phb9L8HiEuqhhAHSCJPgudhKdQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: use relative symlinks for anything pulled from PREMIRRORS
To: "Hombourger, Cedric" <Cedric_Hombourger@mentor.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Chris Larson <Chris_Larson@mentor.com>
Content-Type: multipart/alternative; boundary="0000000000007a90ed05b5170157"

--0000000000007a90ed05b5170157
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Unfortunately this seems to completely break SSTATE_MIRROR handling file://
at least in some setups.

All setscene tasks are failing, because there is a symlink in sstate-cache=
,
but when trying to use it, it points to relative path into wrong directory=
.

e.g.
DEBUG: Executing python function do_package_qa_setscene
DEBUG: Searching for
fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512=
f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz
in paths:
    /jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache
DEBUG: Defaulting to
/jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache/fb/a4/sstate=
:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b6=
5244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz
for fb/a4/sstate:python3-ifcfg:cor
texa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f=
4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz
DEBUG: Testing URL
file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:f=
ba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.=
tgz;downloadfilename=3Dfb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r=
0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d=
8b2_package_qa.tgz
DEBUG: For url ['file', '',
'fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a51=
2f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz',
'', '', OrderedDict([('downloadfilename',
'fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a51=
2f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz')]=
)]
comparing ['file', '', '.*', '', '', OrderedDict()] to ['file', '',
'/mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/PATH', '',
'', OrderedDict()]
DEBUG: For url
file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:f=
ba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.=
tgz;downloadfilename=3Dfb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r=
0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d=
8b2_package_qa.tgz
returning
file:///mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/fb/a4/=
sstate%3Apython3-ifcfg%3Acortexa72-oe-linux%3A0.21%3Ar0%3Acortexa72%3A3%3Af=
ba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.=
tgz;downloadfilename=3Dfb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r=
0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d=
8b2_package_qa.tgz
DEBUG: Trying PREMIRRORS
DEBUG: For url ['file', '',
'fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a51=
2f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz',
'', '', OrderedDict([('downloadfilename',
'fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a51=
2f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz')]=
)]
comparing ['file', '', '.*', '', '', OrderedDict()] to ['file', '',
'/mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/PATH', '',
'', OrderedDict()]
DEBUG: For url
file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:f=
ba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.=
tgz;downloadfilename=3Dfb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r=
0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d=
8b2_package_qa.tgz
returning
file:///mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/fb/a4/=
sstate%3Apython3-ifcfg%3Acortexa72-oe-linux%3A0.21%3Ar0%3Acortexa72%3A3%3Af=
ba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.=
tgz;downloadfilename=3Dfb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r=
0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d=
8b2_package_qa.tgz
DEBUG: Searching for
fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512=
f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.sig=
info
in paths:
    /jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache
DEBUG: Defaulting to
/jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache/fb/a4/sstate=
:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b6=
5244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo
for
fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512=
f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.sig=
info
DEBUG: Testing URL
file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:f=
ba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.=
tgz.siginfo;downloadfilename=3Dfb/a4/sstate:python3-ifcfg:cortexa72-oe-linu=
x:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7=
cbcf8b5d8b2_package_qa.tgz.siginfo
DEBUG: For url ['file', '',
'fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a51=
2f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.si=
ginfo',
'', '', OrderedDict([('downloadfilename',
'fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a51=
2f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.si=
ginfo')])]
comparing ['file', '', '.*', '', '', OrderedDict()] to ['file', '',
'/mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/PATH', '',
'', OrderedDict()]
DEBUG: For url
file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:f=
ba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.=
tgz.siginfo;downloadfilename=3Dfb/a4/sstate:python3-ifcfg:cortexa72-oe-linu=
x:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7=
cbcf8b5d8b2_package_qa.tgz.siginfo
returning
file:///mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/fb/a4/=
sstate%3Apython3-ifcfg%3Acortexa72-oe-linux%3A0.21%3Ar0%3Acortexa72%3A3%3Af=
ba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.=
tgz.siginfo;downloadfilename=3Dfb/a4/sstate:python3-ifcfg:cortexa72-oe-linu=
x:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7=
cbcf8b5d8b2_package_qa.tgz.siginfo
DEBUG: Trying PREMIRRORS
DEBUG: For url ['file', '',
'fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a51=
2f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.si=
ginfo',
'', '', OrderedDict([('downloadfilename',
'fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a51=
2f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.si=
ginfo')])]
comparing ['file', '', '.*', '', '', OrderedDict()] to ['file', '',
'/mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/PATH', '',
'', OrderedDict()]
DEBUG: For url
file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:f=
ba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.=
tgz.siginfo;downloadfilename=3Dfb/a4/sstate:python3-ifcfg:cortexa72-oe-linu=
x:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7=
cbcf8b5d8b2_package_qa.tgz.siginfo
returning
file:///mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/fb/a4/=
sstate%3Apython3-ifcfg%3Acortexa72-oe-linux%3A0.21%3Ar0%3Acortexa72%3A3%3Af=
ba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.=
tgz.siginfo;downloadfilename=3Dfb/a4/sstate:python3-ifcfg:cortexa72-oe-linu=
x:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7=
cbcf8b5d8b2_package_qa.tgz.siginfo
NOTE: Sstate package
/jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache/fb/a4/sstate=
:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b6=
5244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz
does not exist
ERROR: No suitable staging package found
DEBUG: Python function do_package_qa_setscene finished

$ ls -lah
"/jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache/fb/a4/sstat=
e:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b=
65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz"
lrwxrwxrwx 1 mjansa mjansa 229 Nov 27 05:41
/jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache/fb/a4/sstate=
:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b6=
5244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz
->
../../../../../../../../mnt/mirror-write-ros/jansa/webos/ros-hardknott/sst=
ate-cache/fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3=
:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_q=
a.tgz



On Wed, Nov 18, 2020 at 4:36 PM Hombourger, Cedric <
Cedric_Hombourger@mentor.com> wrote:

> try_mirror_url() creates a symlink named as the original file to make
> everything look like files specified in SRC_URI were downloaded from
> their original location. The link is however created as an absolute
> reference, this makes DL_DIR non-relocatable. This also causes issues
> with the Isar project since it bind mounts DL_DIR to /downloads to
> perform some of its build tasks in a chrooted environment (rendering
> all symbolic links from DL_DIR invalid). Modify ensure_symlink() to
> take an optional "relative" argument and have that function use
> os.path.relpath() to produce a relative symlink.
>
> Signed-off-by: Cedric Hombourger <Cedric_Hombourger@mentor.com>
> Cc: Chris Larson <Chris_Larson@mentor.com>
> ---
>  lib/bb/fetch2/__init__.py | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index ca81bd52..e090cd86 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -1026,7 +1026,8 @@ def try_mirror_url(fetch, origud, ud, ld, check =
=3D
> False):
>                      origud.method.build_mirror_data(origud, ld)
>              return origud.localpath
>          # Otherwise the result is a local file:// and we symlink to it
> -        ensure_symlink(ud.localpath, origud.localpath)
> +        ensure_symlink(ud.localpath, origud.localpath, relative=3DTrue)
> +
>          update_stamp(origud, ld)
>          return ud.localpath
>
> @@ -1060,7 +1061,7 @@ def try_mirror_url(fetch, origud, ud, ld, check =
=3D
> False):
>              bb.utils.unlockfile(lf)
>
>
> -def ensure_symlink(target, link_name):
> +def ensure_symlink(target, link_name, relative=3DFalse):
>      if not os.path.exists(link_name):
>          if os.path.islink(link_name):
>              # Broken symbolic link
> @@ -1071,6 +1072,8 @@ def ensure_symlink(target, link_name):
>          # same time, in which case we do not want the second task to
>          # fail when the link has already been created by the first task=
.
>          try:
> +            if relative is True:
> +                target =3D os.path.relpath(target,
> os.path.dirname(link_name))
>              os.symlink(target, link_name)
>          except FileExistsError:
>              pass
> --
> 2.25.1
>
>
>=20
>
>

--0000000000007a90ed05b5170157
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Unfortunately this seems to completely break SSTATE_MIRROR=
 handling file:// at least in some setups.<div><br></div><div>All setscene =
tasks are failing, because there is a symlink in sstate-cache, but when try=
ing to use it, it points to relative path into wrong directory.</div><div><=
br></div><div>e.g.</div><div>DEBUG: Executing python function do_package_qa=
_setscene<br>DEBUG: Searching for fb/a4/sstate:python3-ifcfg:cortexa72-oe-l=
inux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b17=
8a7cbcf8b5d8b2_package_qa.tgz in paths:<br>=C2=A0 =C2=A0 /jenkins/mjansa/bu=
ild/ros/ros2-rolling-hardknott/sstate-cache<br>DEBUG: Defaulting to /jenkin=
s/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache/fb/a4/sstate:python3=
-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828=
d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz for fb/a4/sstate:python3=
-ifcfg:cor<br>texa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244=
a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz<br>DEBUG: Testing UR=
L file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:=
fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa=
.tgz;downloadfilename=3Dfb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:=
r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5=
d8b2_package_qa.tgz<br>DEBUG: For url [&#39;file&#39;, &#39;&#39;, &#39;fb/=
a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137=
dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz&#39;, &=
#39;&#39;, &#39;&#39;, OrderedDict([(&#39;downloadfilename&#39;, &#39;fb/a4=
/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dc=
ed352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz&#39;)])] =
comparing [&#39;file&#39;, &#39;&#39;, &#39;.*&#39;, &#39;&#39;, &#39;&#39;=
, OrderedDict()] to [&#39;file&#39;, &#39;&#39;, &#39;/mnt/mirror-write-ros=
/jansa/webos/ros-hardknott/sstate-cache/PATH&#39;, &#39;&#39;, &#39;&#39;, =
OrderedDict()]<br>DEBUG: For url file://fb/a4/sstate:python3-ifcfg:cortexa7=
2-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899=
c45b178a7cbcf8b5d8b2_package_qa.tgz;downloadfilename=3Dfb/a4/sstate:python3=
-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828=
d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz returning file:///mnt/mi=
rror-write-ros/jansa/webos/ros-hardknott/sstate-cache/fb/a4/sstate%3Apython=
3-ifcfg%3Acortexa72-oe-linux%3A0.21%3Ar0%3Acortexa72%3A3%3Afba4a512f137dced=
352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz;downloadfil=
ename=3Dfb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:f=
ba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.=
tgz<br>DEBUG: Trying PREMIRRORS<br>DEBUG: For url [&#39;file&#39;, &#39;&#3=
9;, &#39;fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:=
fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa=
.tgz&#39;, &#39;&#39;, &#39;&#39;, OrderedDict([(&#39;downloadfilename&#39;=
, &#39;fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fb=
a4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.t=
gz&#39;)])] comparing [&#39;file&#39;, &#39;&#39;, &#39;.*&#39;, &#39;&#39;=
, &#39;&#39;, OrderedDict()] to [&#39;file&#39;, &#39;&#39;, &#39;/mnt/mirr=
or-write-ros/jansa/webos/ros-hardknott/sstate-cache/PATH&#39;, &#39;&#39;, =
&#39;&#39;, OrderedDict()]<br>DEBUG: For url file://fb/a4/sstate:python3-if=
cfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d60=
14453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz;downloadfilename=3Dfb/a4/ss=
tate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced3=
52b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz returning fi=
le:///mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/fb/a4/sst=
ate%3Apython3-ifcfg%3Acortexa72-oe-linux%3A0.21%3Ar0%3Acortexa72%3A3%3Afba4=
a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz=
;downloadfilename=3Dfb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:c=
ortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2=
_package_qa.tgz<br>DEBUG: Searching for fb/a4/sstate:python3-ifcfg:cortexa7=
2-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899=
c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo in paths:<br>=C2=A0 =C2=A0 /jen=
kins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache<br>DEBUG: Default=
ing to /jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache/fb/a4/=
sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dce=
d352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo fo=
r fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a51=
2f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.si=
ginfo<br>DEBUG: Testing URL file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-=
linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b1=
78a7cbcf8b5d8b2_package_qa.tgz.siginfo;downloadfilename=3Dfb/a4/sstate:pyth=
on3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a=
828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo<br>DEBUG: For=
 url [&#39;file&#39;, &#39;&#39;, &#39;fb/a4/sstate:python3-ifcfg:cortexa72=
-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c=
45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo&#39;, &#39;&#39;, &#39;&#39;, Or=
deredDict([(&#39;downloadfilename&#39;, &#39;fb/a4/sstate:python3-ifcfg:cor=
texa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4=
f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo&#39;)])] comparing [&#39;f=
ile&#39;, &#39;&#39;, &#39;.*&#39;, &#39;&#39;, &#39;&#39;, OrderedDict()] =
to [&#39;file&#39;, &#39;&#39;, &#39;/mnt/mirror-write-ros/jansa/webos/ros-=
hardknott/sstate-cache/PATH&#39;, &#39;&#39;, &#39;&#39;, OrderedDict()]<br=
>DEBUG: For url file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r=
0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d=
8b2_package_qa.tgz.siginfo;downloadfilename=3Dfb/a4/sstate:python3-ifcfg:co=
rtexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f=
4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo returning file:///mnt/mir=
ror-write-ros/jansa/webos/ros-hardknott/sstate-cache/fb/a4/sstate%3Apython3=
-ifcfg%3Acortexa72-oe-linux%3A0.21%3Ar0%3Acortexa72%3A3%3Afba4a512f137dced3=
52b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo;down=
loadfilename=3Dfb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortex=
a72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_pack=
age_qa.tgz.siginfo<br>DEBUG: Trying PREMIRRORS<br>DEBUG: For url [&#39;file=
&#39;, &#39;&#39;, &#39;fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:=
r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5=
d8b2_package_qa.tgz.siginfo&#39;, &#39;&#39;, &#39;&#39;, OrderedDict([(&#3=
9;downloadfilename&#39;, &#39;fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux=
:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7c=
bcf8b5d8b2_package_qa.tgz.siginfo&#39;)])] comparing [&#39;file&#39;, &#39;=
&#39;, &#39;.*&#39;, &#39;&#39;, &#39;&#39;, OrderedDict()] to [&#39;file&#=
39;, &#39;&#39;, &#39;/mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstat=
e-cache/PATH&#39;, &#39;&#39;, &#39;&#39;, OrderedDict()]<br>DEBUG: For url=
 file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:f=
ba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.=
tgz.siginfo;downloadfilename=3Dfb/a4/sstate:python3-ifcfg:cortexa72-oe-linu=
x:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7=
cbcf8b5d8b2_package_qa.tgz.siginfo returning file:///mnt/mirror-write-ros/j=
ansa/webos/ros-hardknott/sstate-cache/fb/a4/sstate%3Apython3-ifcfg%3Acortex=
a72-oe-linux%3A0.21%3Ar0%3Acortexa72%3A3%3Afba4a512f137dced352b65244a828d60=
14453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo;downloadfilename=3D=
fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f=
137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.sigi=
nfo<br>NOTE: Sstate package /jenkins/mjansa/build/ros/ros2-rolling-hardknot=
t/sstate-cache/fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortex=
a72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_pack=
age_qa.tgz does not exist<br>ERROR: No suitable staging package found<br>DE=
BUG: Python function do_package_qa_setscene finished</div><div><br></div><d=
iv>$ ls -lah &quot;/jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-=
cache/fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba=
4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tg=
z&quot;<br>lrwxrwxrwx 1 mjansa mjansa 229 Nov 27 05:41 /jenkins/mjansa/buil=
d/ros/ros2-rolling-hardknott/sstate-cache/fb/a4/sstate:python3-ifcfg:cortex=
a72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f38=
99c45b178a7cbcf8b5d8b2_package_qa.tgz -&gt; ../../../../../../../../mnt/mir=
ror-write-ros/jansa/webos/ros-hardknott/sstate-cache/fb/a4/sstate:python3-i=
fcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6=
014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz<br><div><br></div><div><br=
></div></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Wed, Nov 18, 2020 at 4:36 PM Hombourger, Cedric &lt;<a href=
=
=3D"mailto:Cedric_Hombourger@mentor.com">Cedric_Hombourger@mentor.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">try_m=
irror_url() creates a symlink named as the original file to make<br>
everything look like files specified in SRC_URI were downloaded from<br>
their original location. The link is however created as an absolute<br>
reference, this makes DL_DIR non-relocatable. This also causes issues<br>
with the Isar project since it bind mounts DL_DIR to /downloads to<br>
perform some of its build tasks in a chrooted environment (rendering<br>
all symbolic links from DL_DIR invalid). Modify ensure_symlink() to<br>
take an optional &quot;relative&quot; argument and have that function use<=
br>
os.path.relpath() to produce a relative symlink.<br>
<br>
Signed-off-by: Cedric Hombourger &lt;<a href=3D"mailto:Cedric_Hombourger@m=
entor.com" target=3D"_blank">Cedric_Hombourger@mentor.com</a>&gt;<br>
Cc: Chris Larson &lt;<a href=3D"mailto:Chris_Larson@mentor.com" target=3D"=
_blank">Chris_Larson@mentor.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/fetch2/__init__.py | 7 +++++--<br>
=C2=A01 file changed, 5 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py<br>
index ca81bd52..e090cd86 100644<br>
--- a/lib/bb/fetch2/__init__.py<br>
+++ b/lib/bb/fetch2/__init__.py<br>
@@ -1026,7 +1026,8 @@ def try_mirror_url(fetch, origud, ud, ld, check =3D =
False):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0origud.method.build_mirror_data(origud, ld)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return origud.localpath<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Otherwise the result is a local file:/=
/ and we symlink to it<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ensure_symlink(ud.localpath, origud.localpath=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ensure_symlink(ud.localpath, origud.localpath=
, relative=3DTrue)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0update_stamp(origud, ld)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ud.localpath<br>
<br>
@@ -1060,7 +1061,7 @@ def try_mirror_url(fetch, origud, ud, ld, check =3D =
False):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.utils.unlockfile(lf)<br=
>
<br>
<br>
-def ensure_symlink(target, link_name):<br>
+def ensure_symlink(target, link_name, relative=3DFalse):<br>
=C2=A0 =C2=A0 =C2=A0if not os.path.exists(link_name):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if os.path.islink(link_name):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Broken symbolic link<br>
@@ -1071,6 +1072,8 @@ def ensure_symlink(target, link_name):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# same time, in which case we do not wan=
t the second task to<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# fail when the link has already been cr=
eated by the first task.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if relative is True:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target =3D os.pat=
h.relpath(target, os.path.dirname(link_name))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0os.symlink(target, link_na=
me)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except FileExistsError:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
-- <br>
2.25.1<br>
<br>
<br>
<br>
<br>
</blockquote></div>

--0000000000007a90ed05b5170157--
