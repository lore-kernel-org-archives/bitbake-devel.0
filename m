Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.web12.7326.1606925552137795180
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Dec 2020 08:12:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=PA9K21Vv;
 spf=pass (domain: gmail.com, ip: 209.85.218.44, mailfrom: martin.jansa@gmail.com)
Received: by mail-ej1-f44.google.com with SMTP id d17so5153915ejy.9
        for <bitbake-devel@lists.openembedded.org>; Wed, 02 Dec 2020 08:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zr6orw6YHjWvIxc2ohU70jl792yaiwg4jl8qZ5+i01w=;
        b=PA9K21Vv8tO7mZhdyeXzUR7mlcgi/ZOBCJygIYhmp11EwGYiSbhNKv07Rg6Q1r/Rkk
         K3syVfBVfK1xjlkf7Zg9HKgSlsNjYCAeA0U8t6QKan9IaU111T2Qc+5qW/XoD0yG0UGb
         APjouWTWtrsv8vi43nmQIZQFz6YqgEOeh24D70eti8AGbhGGG0sdHvvOlnU4Qy6eHpC9
         jW72EWre3H3MMgBhXoxm60mQfhpNvgLfZLFwAfHhG/Du4pYaNt+9bZXSMmD2DZoQcZmd
         xsOtTCnDHTgh7lQF56LgZu/RhO0wu9arFtSID+CLQiuZuQc08MxqfxVGn5A9l9wCXbQL
         MS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zr6orw6YHjWvIxc2ohU70jl792yaiwg4jl8qZ5+i01w=;
        b=CwAU+cLCmimEEJl4tqgG7eWS5VZmi9D0dIpAVepgXNgQaQUnoUSim6ApVLt8mulhHQ
         WQXSSFcBuAOsvSNEbdSBZ5DBuj9m5p2nVTuUYZayNtUqfgSDhsiSLqKzkygomTn6aSgP
         QAida7BA8dFlKfC2FWvoiVVUdNKde49G6DPq0nNf/MR1OMW9zT4hzgn7qx5QqDESopu7
         5woFMsGNwdUBjsBxuWhwVHV2mQ5zgqCJo2kRG7kfrQPnvIqOgQ91WObZhzM0ISk9MNfL
         AaP07nV9o4+D05Ylre1CEfqyzX/qbEGyK4KaenFcplU9i+bwy6lKKZodNZ+rx1CroejN
         9D2A==
X-Gm-Message-State: AOAM531JqF6Iv4noAcj8ZzmECUQClpePEwBRbj0bTpKri1Ctxc93f4zx
	cvU03UYSvuY1hi4MB52BEL07osBG/w24S6PwupA=
X-Google-Smtp-Source: ABdhPJyUp3OKwnNxHZt+KfEBGtgNvdTwRQ8+jxCaMWJtQB66P1erxxp94jcA6Fy/asi/eAOwj2W6i5zQMm7mqFdvaNU=
X-Received: by 2002:a17:906:5182:: with SMTP id y2mr434234ejk.471.1606925550464;
 Wed, 02 Dec 2020 08:12:30 -0800 (PST)
MIME-Version: 1.0
References: <20201118153613.811-1-Cedric_Hombourger@mentor.com>
 <CA+chaQez30Xyf-e+PDMOa5G-Phb9L8HiEuqhhAHSCJPgudhKdQ@mail.gmail.com> <92262695-8578-94cc-939b-fcc49af7b428@mentor.com>
In-Reply-To: <92262695-8578-94cc-939b-fcc49af7b428@mentor.com>
From: "Martin Jansa" <Martin.Jansa@gmail.com>
Date: Wed, 2 Dec 2020 17:12:19 +0100
Message-ID: <CA+chaQfzioSjdTnwJyv6KDLsDmbEywBnSA-vdn0TB2P1Bkn84A@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: use relative symlinks for anything pulled from PREMIRRORS
To: Cedric Hombourger <cedric_hombourger@mentor.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Chris Larson <Chris_Larson@mentor.com>
Content-Type: multipart/alternative; boundary="0000000000009db0f305b57d8279"

--0000000000009db0f305b57d8279
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

any update on this?

Is anyone else seeing the same issue?

Cheers,

On Fri, Nov 27, 2020 at 3:04 PM Cedric Hombourger <
cedric_hombourger@mentor.com> wrote:

>
> On 11/27/20 2:54 PM, Martin Jansa wrote:
>
> Unfortunately this seems to completely break SSTATE_MIRROR handling
> file:// at least in some setups.
>
> thank you so much for the feedback. I will check what's wrong there.
>
>
> All setscene tasks are failing, because there is a symlink in
> sstate-cache, but when trying to use it, it points to relative path into
> wrong directory.
>
> e.g.
> DEBUG: Executing python function do_package_qa_setscene
> DEBUG: Searching for
> fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a5=
12f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz
> in paths:
>     /jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache
> DEBUG: Defaulting to
> /jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache/fb/a4/ssta=
te:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352=
b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz
> for fb/a4/sstate:python3-ifcfg:cor
>
> texa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d601445=
3f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz
> DEBUG: Testing URL
> file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3=
:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_q=
a.tgz;downloadfilename=3Dfb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21=
:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b=
5d8b2_package_qa.tgz
> DEBUG: For url ['file', '',
> 'fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a=
512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz'=
,
> '', '', OrderedDict([('downloadfilename',
> 'fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a=
512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz'=
)])]
> comparing ['file', '', '.*', '', '', OrderedDict()] to ['file', '',
> '/mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/PATH', '',
> '', OrderedDict()]
> DEBUG: For url
> file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3=
:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_q=
a.tgz;downloadfilename=3Dfb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21=
:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b=
5d8b2_package_qa.tgz
> returning
> file:///mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/fb/a=
4/sstate%3Apython3-ifcfg%3Acortexa72-oe-linux%3A0.21%3Ar0%3Acortexa72%3A3%3=
Afba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_q=
a.tgz;downloadfilename=3Dfb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21=
:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b=
5d8b2_package_qa.tgz
> DEBUG: Trying PREMIRRORS
> DEBUG: For url ['file', '',
> 'fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a=
512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz'=
,
> '', '', OrderedDict([('downloadfilename',
> 'fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a=
512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz'=
)])]
> comparing ['file', '', '.*', '', '', OrderedDict()] to ['file', '',
> '/mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/PATH', '',
> '', OrderedDict()]
> DEBUG: For url
> file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3=
:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_q=
a.tgz;downloadfilename=3Dfb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21=
:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b=
5d8b2_package_qa.tgz
> returning
> file:///mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/fb/a=
4/sstate%3Apython3-ifcfg%3Acortexa72-oe-linux%3A0.21%3Ar0%3Acortexa72%3A3%3=
Afba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_q=
a.tgz;downloadfilename=3Dfb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21=
:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b=
5d8b2_package_qa.tgz
> DEBUG: Searching for
> fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a5=
12f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.s=
iginfo
> in paths:
>     /jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache
> DEBUG: Defaulting to
> /jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache/fb/a4/ssta=
te:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352=
b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo
> for
> fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a5=
12f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.s=
iginfo
> DEBUG: Testing URL
> file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3=
:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_q=
a.tgz.siginfo;downloadfilename=3Dfb/a4/sstate:python3-ifcfg:cortexa72-oe-li=
nux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178=
a7cbcf8b5d8b2_package_qa.tgz.siginfo
> DEBUG: For url ['file', '',
> 'fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a=
512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.=
siginfo',
> '', '', OrderedDict([('downloadfilename',
> 'fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a=
512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.=
siginfo')])]
> comparing ['file', '', '.*', '', '', OrderedDict()] to ['file', '',
> '/mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/PATH', '',
> '', OrderedDict()]
> DEBUG: For url
> file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3=
:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_q=
a.tgz.siginfo;downloadfilename=3Dfb/a4/sstate:python3-ifcfg:cortexa72-oe-li=
nux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178=
a7cbcf8b5d8b2_package_qa.tgz.siginfo
> returning
> file:///mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/fb/a=
4/sstate%3Apython3-ifcfg%3Acortexa72-oe-linux%3A0.21%3Ar0%3Acortexa72%3A3%3=
Afba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_q=
a.tgz.siginfo;downloadfilename=3Dfb/a4/sstate:python3-ifcfg:cortexa72-oe-li=
nux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178=
a7cbcf8b5d8b2_package_qa.tgz.siginfo
> DEBUG: Trying PREMIRRORS
> DEBUG: For url ['file', '',
> 'fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a=
512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.=
siginfo',
> '', '', OrderedDict([('downloadfilename',
> 'fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a=
512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.=
siginfo')])]
> comparing ['file', '', '.*', '', '', OrderedDict()] to ['file', '',
> '/mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/PATH', '',
> '', OrderedDict()]
> DEBUG: For url
> file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3=
:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_q=
a.tgz.siginfo;downloadfilename=3Dfb/a4/sstate:python3-ifcfg:cortexa72-oe-li=
nux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178=
a7cbcf8b5d8b2_package_qa.tgz.siginfo
> returning
> file:///mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/fb/a=
4/sstate%3Apython3-ifcfg%3Acortexa72-oe-linux%3A0.21%3Ar0%3Acortexa72%3A3%3=
Afba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_q=
a.tgz.siginfo;downloadfilename=3Dfb/a4/sstate:python3-ifcfg:cortexa72-oe-li=
nux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178=
a7cbcf8b5d8b2_package_qa.tgz.siginfo
> NOTE: Sstate package
> /jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache/fb/a4/ssta=
te:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352=
b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz
> does not exist
> ERROR: No suitable staging package found
> DEBUG: Python function do_package_qa_setscene finished
>
> $ ls -lah
> "/jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache/fb/a4/sst=
ate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced35=
2b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz"
> lrwxrwxrwx 1 mjansa mjansa 229 Nov 27 05:41
> /jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache/fb/a4/ssta=
te:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352=
b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz
> ->
> ../../../../../../../../mnt/mirror-write-ros/jansa/webos/ros-hardknott/s=
state-cache/fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72=
:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package=
_qa.tgz
>
>
>
> On Wed, Nov 18, 2020 at 4:36 PM Hombourger, Cedric <
> Cedric_Hombourger@mentor.com> wrote:
>
>> try_mirror_url() creates a symlink named as the original file to make
>> everything look like files specified in SRC_URI were downloaded from
>> their original location. The link is however created as an absolute
>> reference, this makes DL_DIR non-relocatable. This also causes issues
>> with the Isar project since it bind mounts DL_DIR to /downloads to
>> perform some of its build tasks in a chrooted environment (rendering
>> all symbolic links from DL_DIR invalid). Modify ensure_symlink() to
>> take an optional "relative" argument and have that function use
>> os.path.relpath() to produce a relative symlink.
>>
>> Signed-off-by: Cedric Hombourger <Cedric_Hombourger@mentor.com>
>> Cc: Chris Larson <Chris_Larson@mentor.com>
>> ---
>>  lib/bb/fetch2/__init__.py | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
>> index ca81bd52..e090cd86 100644
>> --- a/lib/bb/fetch2/__init__.py
>> +++ b/lib/bb/fetch2/__init__.py
>> @@ -1026,7 +1026,8 @@ def try_mirror_url(fetch, origud, ud, ld, check =
=3D
>> False):
>>                      origud.method.build_mirror_data(origud, ld)
>>              return origud.localpath
>>          # Otherwise the result is a local file:// and we symlink to it
>> -        ensure_symlink(ud.localpath, origud.localpath)
>> +        ensure_symlink(ud.localpath, origud.localpath, relative=3DTrue=
)
>> +
>>          update_stamp(origud, ld)
>>          return ud.localpath
>>
>> @@ -1060,7 +1061,7 @@ def try_mirror_url(fetch, origud, ud, ld, check =
=3D
>> False):
>>              bb.utils.unlockfile(lf)
>>
>>
>> -def ensure_symlink(target, link_name):
>> +def ensure_symlink(target, link_name, relative=3DFalse):
>>      if not os.path.exists(link_name):
>>          if os.path.islink(link_name):
>>              # Broken symbolic link
>> @@ -1071,6 +1072,8 @@ def ensure_symlink(target, link_name):
>>          # same time, in which case we do not want the second task to
>>          # fail when the link has already been created by the first tas=
k.
>>          try:
>> +            if relative is True:
>> +                target =3D os.path.relpath(target,
>> os.path.dirname(link_name))
>>              os.symlink(target, link_name)
>>          except FileExistsError:
>>              pass
>> --
>> 2.25.1
>>
>>
>>
>>
>>
>=20
>
>
>

--0000000000009db0f305b57d8279
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>any update on this?</div><div><br><=
/div><div>Is anyone else seeing the same issue?</div><div><br></div><div>Ch=
eers,</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">On Fri, Nov 27, 2020 at 3:04 PM Cedric Hombourger &lt;<a href=3D=
"mailto:cedric_hombourger@mentor.com">cedric_hombourger@mentor.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
  
    
  
  <div>
    <p><br>
    </p>
    <div>On 11/27/20 2:54 PM, Martin Jansa
      wrote:<br>
    </div>
    <blockquote type=3D"cite">
      
      <div dir=3D"ltr">Unfortunately this seems to completely break
        SSTATE_MIRROR handling <a>file://</a> at least in some setups.</di=
v>
    </blockquote>
    thank you so much for the feedback. I will check what&#39;s wrong ther=
e.<br>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div><br>
        </div>
        <div>All setscene tasks are failing, because there is a symlink
          in sstate-cache, but when trying to use it, it points to
          relative path into wrong directory.</div>
        <div><br>
        </div>
        <div>e.g.</div>
        <div>DEBUG: Executing python function do_package_qa_setscene<br>
          DEBUG: Searching for
fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512=
f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz
          in paths:<br>
          =C2=A0 =C2=A0
          /jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache<br=
>
          DEBUG: Defaulting to
/jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache/fb/a4/sstate=
:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b6=
5244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz
          for fb/a4/sstate:python3-ifcfg:cor<br>
texa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f=
4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz<br>
          DEBUG: Testing URL
<a>file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:=
3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_=
qa.tgz;downloadfilename=3Dfb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.2=
1:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8=
b5d8b2_package_qa.tgz</a><br>
          DEBUG: For url [&#39;file&#39;, &#39;&#39;,
&#39;fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba=
4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tg=
z&#39;,
          &#39;&#39;, &#39;&#39;, OrderedDict([(&#39;downloadfilename&#39;=
,
&#39;fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba=
4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tg=
z&#39;)])]
          comparing [&#39;file&#39;, &#39;&#39;, &#39;.*&#39;, &#39;&#39;,=
 &#39;&#39;, OrderedDict()] to
          [&#39;file&#39;, &#39;&#39;,
          &#39;/mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cach=
e/PATH&#39;,
          &#39;&#39;, &#39;&#39;, OrderedDict()]<br>
          DEBUG: For url
<a>file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:=
3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_=
qa.tgz;downloadfilename=3Dfb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.2=
1:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8=
b5d8b2_package_qa.tgz</a>
          returning
<a>file:///mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/fb/=
a4/sstate%3Apython3-ifcfg%3Acortexa72-oe-linux%3A0.21%3Ar0%3Acortexa72%3A3%=
3Afba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_=
qa.tgz;downloadfilename=3Dfb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.2=
1:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8=
b5d8b2_package_qa.tgz</a><br>
          DEBUG: Trying PREMIRRORS<br>
          DEBUG: For url [&#39;file&#39;, &#39;&#39;,
&#39;fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba=
4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tg=
z&#39;,
          &#39;&#39;, &#39;&#39;, OrderedDict([(&#39;downloadfilename&#39;=
,
&#39;fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba=
4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tg=
z&#39;)])]
          comparing [&#39;file&#39;, &#39;&#39;, &#39;.*&#39;, &#39;&#39;,=
 &#39;&#39;, OrderedDict()] to
          [&#39;file&#39;, &#39;&#39;,
          &#39;/mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cach=
e/PATH&#39;,
          &#39;&#39;, &#39;&#39;, OrderedDict()]<br>
          DEBUG: For url
<a>file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:=
3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_=
qa.tgz;downloadfilename=3Dfb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.2=
1:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8=
b5d8b2_package_qa.tgz</a>
          returning
<a>file:///mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/fb/=
a4/sstate%3Apython3-ifcfg%3Acortexa72-oe-linux%3A0.21%3Ar0%3Acortexa72%3A3%=
3Afba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_=
qa.tgz;downloadfilename=3Dfb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.2=
1:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8=
b5d8b2_package_qa.tgz</a><br>
          DEBUG: Searching for
fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512=
f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.sig=
info
          in paths:<br>
          =C2=A0 =C2=A0
          /jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache<br=
>
          DEBUG: Defaulting to
/jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache/fb/a4/sstate=
:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b6=
5244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo
          for
fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512=
f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.sig=
info<br>
          DEBUG: Testing URL
<a>file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:=
3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_=
qa.tgz.siginfo;downloadfilename=3Dfb/a4/sstate:python3-ifcfg:cortexa72-oe-l=
inux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b17=
8a7cbcf8b5d8b2_package_qa.tgz.siginfo</a><br>
          DEBUG: For url [&#39;file&#39;, &#39;&#39;,
&#39;fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba=
4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tg=
z.siginfo&#39;,
          &#39;&#39;, &#39;&#39;, OrderedDict([(&#39;downloadfilename&#39;=
,
&#39;fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba=
4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tg=
z.siginfo&#39;)])]
          comparing [&#39;file&#39;, &#39;&#39;, &#39;.*&#39;, &#39;&#39;,=
 &#39;&#39;, OrderedDict()] to
          [&#39;file&#39;, &#39;&#39;,
          &#39;/mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cach=
e/PATH&#39;,
          &#39;&#39;, &#39;&#39;, OrderedDict()]<br>
          DEBUG: For url
<a>file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:=
3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_=
qa.tgz.siginfo;downloadfilename=3Dfb/a4/sstate:python3-ifcfg:cortexa72-oe-l=
inux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b17=
8a7cbcf8b5d8b2_package_qa.tgz.siginfo</a>
          returning
<a>file:///mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/fb/=
a4/sstate%3Apython3-ifcfg%3Acortexa72-oe-linux%3A0.21%3Ar0%3Acortexa72%3A3%=
3Afba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_=
qa.tgz.siginfo;downloadfilename=3Dfb/a4/sstate:python3-ifcfg:cortexa72-oe-l=
inux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b17=
8a7cbcf8b5d8b2_package_qa.tgz.siginfo</a><br>
          DEBUG: Trying PREMIRRORS<br>
          DEBUG: For url [&#39;file&#39;, &#39;&#39;,
&#39;fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba=
4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tg=
z.siginfo&#39;,
          &#39;&#39;, &#39;&#39;, OrderedDict([(&#39;downloadfilename&#39;=
,
&#39;fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba=
4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tg=
z.siginfo&#39;)])]
          comparing [&#39;file&#39;, &#39;&#39;, &#39;.*&#39;, &#39;&#39;,=
 &#39;&#39;, OrderedDict()] to
          [&#39;file&#39;, &#39;&#39;,
          &#39;/mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cach=
e/PATH&#39;,
          &#39;&#39;, &#39;&#39;, OrderedDict()]<br>
          DEBUG: For url
<a>file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:=
3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_=
qa.tgz.siginfo;downloadfilename=3Dfb/a4/sstate:python3-ifcfg:cortexa72-oe-l=
inux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b17=
8a7cbcf8b5d8b2_package_qa.tgz.siginfo</a>
          returning
<a>file:///mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/fb/=
a4/sstate%3Apython3-ifcfg%3Acortexa72-oe-linux%3A0.21%3Ar0%3Acortexa72%3A3%=
3Afba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_=
qa.tgz.siginfo;downloadfilename=3Dfb/a4/sstate:python3-ifcfg:cortexa72-oe-l=
inux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b17=
8a7cbcf8b5d8b2_package_qa.tgz.siginfo</a><br>
          NOTE: Sstate package
/jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache/fb/a4/sstate=
:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b6=
5244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz
          does not exist<br>
          ERROR: No suitable staging package found<br>
          DEBUG: Python function do_package_qa_setscene finished</div>
        <div><br>
        </div>
        <div>$ ls -lah
&quot;/jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache/fb/a4/=
sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dce=
d352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz&quot;<br>
          lrwxrwxrwx 1 mjansa mjansa 229 Nov 27 05:41
/jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache/fb/a4/sstate=
:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b6=
5244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz
          -&gt;
../../../../../../../../mnt/mirror-write-ros/jansa/webos/ros-hardknott/sst=
ate-cache/fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3=
:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_q=
a.tgz<br>
          <div><br>
          </div>
          <div><br>
          </div>
        </div>
      </div>
      <br>
      <div class=3D"gmail_quote">
        <div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 18, 2020 at 4:36
          PM Hombourger, Cedric &lt;<a href=3D"mailto:Cedric_Hombourger@me=
ntor.com" target=3D"_blank">Cedric_Hombourger@mentor.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">try_mirror_url()
          creates a symlink named as the original file to make<br>
          everything look like files specified in SRC_URI were
          downloaded from<br>
          their original location. The link is however created as an
          absolute<br>
          reference, this makes DL_DIR non-relocatable. This also causes
          issues<br>
          with the Isar project since it bind mounts DL_DIR to
          /downloads to<br>
          perform some of its build tasks in a chrooted environment
          (rendering<br>
          all symbolic links from DL_DIR invalid). Modify
          ensure_symlink() to<br>
          take an optional &quot;relative&quot; argument and have that fun=
ction
          use<br>
          os.path.relpath() to produce a relative symlink.<br>
          <br>
          Signed-off-by: Cedric Hombourger &lt;<a href=3D"mailto:Cedric_Ho=
mbourger@mentor.com" target=3D"_blank">Cedric_Hombourger@mentor.com</a>&gt;=
<br>
          Cc: Chris Larson &lt;<a href=3D"mailto:Chris_Larson@mentor.com" =
target=3D"_blank">Chris_Larson@mentor.com</a>&gt;<br>
          ---<br>
          =C2=A0lib/bb/fetch2/__init__.py | 7 +++++--<br>
          =C2=A01 file changed, 5 insertions(+), 2 deletions(-)<br>
          <br>
          diff --git a/lib/bb/fetch2/__init__.py
          b/lib/bb/fetch2/__init__.py<br>
          index ca81bd52..e090cd86 100644<br>
          --- a/lib/bb/fetch2/__init__.py<br>
          +++ b/lib/bb/fetch2/__init__.py<br>
          @@ -1026,7 +1026,8 @@ def try_mirror_url(fetch, origud, ud,
          ld, check =3D False):<br>
          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0origud.method.build_mirror_data(origud,
          ld)<br>
          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return origud.lo=
calpath<br>
          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Otherwise the result is a lo=
cal <a>file://</a> and we
          symlink to it<br>
          -=C2=A0 =C2=A0 =C2=A0 =C2=A0 ensure_symlink(ud.localpath, origud=
.localpath)<br>
          +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ensure_symlink(ud.localpath, origud=
.localpath,
          relative=3DTrue)<br>
          +<br>
          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0update_stamp(origud, ld)<br>
          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ud.localpath<br>
          <br>
          @@ -1060,7 +1061,7 @@ def try_mirror_url(fetch, origud, ud,
          ld, check =3D False):<br>
          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.utils.unlockf=
ile(lf)<br>
          <br>
          <br>
          -def ensure_symlink(target, link_name):<br>
          +def ensure_symlink(target, link_name, relative=3DFalse):<br>
          =C2=A0 =C2=A0 =C2=A0if not os.path.exists(link_name):<br>
          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if os.path.islink(link_name):<=
br>
          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Broken symboli=
c link<br>
          @@ -1071,6 +1072,8 @@ def ensure_symlink(target, link_name):<br>
          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# same time, in which case we =
do not want the second
          task to<br>
          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# fail when the link has alrea=
dy been created by the
          first task.<br>
          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
          +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if relative is True:<=
br>
          +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target =
=
=3D os.path.relpath(target,
          os.path.dirname(link_name))<br>
          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0os.symlink(targe=
t, link_name)<br>
          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except FileExistsError:<br>
          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
          -- <br>
          2.25.1<br>
          <br>
          <br>
          <br>
          <br>
        </blockquote>
      </div>
      <br>
      <fieldset></fieldset>
      <pre>

</pre>
    </blockquote>
  </div>

</blockquote></div>

--0000000000009db0f305b57d8279--
