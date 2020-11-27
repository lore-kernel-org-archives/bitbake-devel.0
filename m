Received: from esa2.mentor.iphmx.com (esa2.mentor.iphmx.com [68.232.141.98])
 by mx.groups.io with SMTP id smtpd.web09.19377.1606485853242000341
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Nov 2020 06:04:13 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: mentor.com, ip: 68.232.141.98, mailfrom: cedric_hombourger@mentor.com)
IronPort-SDR: ObAzYMX610akHSWM9TJsNbsUb5rgN5xA5ncXuJF+QpN3gP00FSkodrkRMxTxKFynuvI8x8lQQ1
 QUxHE+ieQ9mA9/URVKB7jIdwA5kfMdjLFIrPwNihiGk5ddxzFwoig54BCJjYP9ysKvIMnauws8
 lACXhc0mogFW+qimjj5gJqneOsnVq0JRNwD04kzr2PYamn481ISw7D/2q4Cq3Gw5U6QMOp0avB
 tMHXwNM4ASHZMcZOpRUY+UagG+ahOO84m6fQEprZHKxsiOHNbx/oaThy2JedQi2NsACz1UiDNz
 NaA=
X-IronPort-AV: E=Sophos;i="5.78,374,1599552000"; 
   d="scan'208,217";a="55558936"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa2.mentor.iphmx.com with ESMTP; 27 Nov 2020 06:04:12 -0800
IronPort-SDR: J1FuR/8jbQH5gZQESh/ZvsGF2sKV4G3mefulQ9IaDi4Za+rujE4nRNB16MM8T005uud8KEfSht
 ABHyxgwN9qk2/nMMCAVDrUFynD4uH0m8tjPrrUFoD6v22FK2EVIwUEUDfGVScfh2V9Y0/VKqig
 Riz4nwX4UNp5a/SaxSazg4qzpvQolY2PYJ4/h8Vj/dmKwv+wGtUkRMPMkD4hani4bquKHbli2h
 av2XDgR5r70U1SIJnfrqSH6d9T/JzTnIcgF78mxt2bIPWoL3VWg6EvfVrmd3KXUSDZwk9fdKxv
 7T8=
Subject: Re: [bitbake-devel] [PATCH] fetch2: use relative symlinks for anything pulled from PREMIRRORS
To: Martin Jansa <Martin.Jansa@gmail.com>
CC: bitbake-devel <bitbake-devel@lists.openembedded.org>, Chris Larson
	<Chris_Larson@mentor.com>
References: <20201118153613.811-1-Cedric_Hombourger@mentor.com>
 <CA+chaQez30Xyf-e+PDMOa5G-Phb9L8HiEuqhhAHSCJPgudhKdQ@mail.gmail.com>
From: "Hombourger, Cedric" <Cedric_Hombourger@mentor.com>
Message-ID: <92262695-8578-94cc-939b-fcc49af7b428@mentor.com>
Date: Fri, 27 Nov 2020 15:04:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CA+chaQez30Xyf-e+PDMOa5G-Phb9L8HiEuqhhAHSCJPgudhKdQ@mail.gmail.com>
Return-Path: cedric_hombourger@mentor.com
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Content-Type: multipart/alternative;
	boundary="------------90217D13E8085BFF0332446F"
Content-Language: en-US

--------------90217D13E8085BFF0332446F
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit


On 11/27/20 2:54 PM, Martin Jansa wrote:
> Unfortunately this seems to completely break SSTATE_MIRROR handling 
> file:// at least in some setups.
thank you so much for the feedback. I will check what's wrong there.
>
> All setscene tasks are failing, because there is a symlink in 
> sstate-cache, but when trying to use it, it points to relative path 
> into wrong directory.
>
> e.g.
> DEBUG: Executing python function do_package_qa_setscene
> DEBUG: Searching for 
> fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz 
> in paths:
> /jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache
> DEBUG: Defaulting to 
> /jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache/fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz 
> for fb/a4/sstate:python3-ifcfg:cor
> texa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz
> DEBUG: Testing URL 
> file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz;downloadfilename=fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz
> DEBUG: For url ['file', '', 
> 'fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz', 
> '', '', OrderedDict([('downloadfilename', 
> 'fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz')])] 
> comparing ['file', '', '.*', '', '', OrderedDict()] to ['file', '', 
> '/mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/PATH', 
> '', '', OrderedDict()]
> DEBUG: For url 
> file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz;downloadfilename=fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz 
> returning 
> file:///mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/fb/a4/sstate%3Apython3-ifcfg%3Acortexa72-oe-linux%3A0.21%3Ar0%3Acortexa72%3A3%3Afba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz;downloadfilename=fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz
> DEBUG: Trying PREMIRRORS
> DEBUG: For url ['file', '', 
> 'fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz', 
> '', '', OrderedDict([('downloadfilename', 
> 'fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz')])] 
> comparing ['file', '', '.*', '', '', OrderedDict()] to ['file', '', 
> '/mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/PATH', 
> '', '', OrderedDict()]
> DEBUG: For url 
> file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz;downloadfilename=fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz 
> returning 
> file:///mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/fb/a4/sstate%3Apython3-ifcfg%3Acortexa72-oe-linux%3A0.21%3Ar0%3Acortexa72%3A3%3Afba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz;downloadfilename=fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz
> DEBUG: Searching for 
> fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo 
> in paths:
> /jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache
> DEBUG: Defaulting to 
> /jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache/fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo 
> for 
> fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo
> DEBUG: Testing URL 
> file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo;downloadfilename=fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo
> DEBUG: For url ['file', '', 
> 'fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo', 
> '', '', OrderedDict([('downloadfilename', 
> 'fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo')])] 
> comparing ['file', '', '.*', '', '', OrderedDict()] to ['file', '', 
> '/mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/PATH', 
> '', '', OrderedDict()]
> DEBUG: For url 
> file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo;downloadfilename=fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo 
> returning 
> file:///mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/fb/a4/sstate%3Apython3-ifcfg%3Acortexa72-oe-linux%3A0.21%3Ar0%3Acortexa72%3A3%3Afba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo;downloadfilename=fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo
> DEBUG: Trying PREMIRRORS
> DEBUG: For url ['file', '', 
> 'fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo', 
> '', '', OrderedDict([('downloadfilename', 
> 'fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo')])] 
> comparing ['file', '', '.*', '', '', OrderedDict()] to ['file', '', 
> '/mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/PATH', 
> '', '', OrderedDict()]
> DEBUG: For url 
> file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo;downloadfilename=fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo 
> returning 
> file:///mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/fb/a4/sstate%3Apython3-ifcfg%3Acortexa72-oe-linux%3A0.21%3Ar0%3Acortexa72%3A3%3Afba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo;downloadfilename=fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo
> NOTE: Sstate package 
> /jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache/fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz 
> does not exist
> ERROR: No suitable staging package found
> DEBUG: Python function do_package_qa_setscene finished
>
> $ ls -lah 
> "/jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache/fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz"
> lrwxrwxrwx 1 mjansa mjansa 229 Nov 27 05:41 
> /jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache/fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz 
> -> 
> ../../../../../../../../mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz
>
>
>
> On Wed, Nov 18, 2020 at 4:36 PM Hombourger, Cedric 
> <Cedric_Hombourger@mentor.com <mailto:Cedric_Hombourger@mentor.com>> 
> wrote:
>
>     try_mirror_url() creates a symlink named as the original file to make
>     everything look like files specified in SRC_URI were downloaded from
>     their original location. The link is however created as an absolute
>     reference, this makes DL_DIR non-relocatable. This also causes issues
>     with the Isar project since it bind mounts DL_DIR to /downloads to
>     perform some of its build tasks in a chrooted environment (rendering
>     all symbolic links from DL_DIR invalid). Modify ensure_symlink() to
>     take an optional "relative" argument and have that function use
>     os.path.relpath() to produce a relative symlink.
>
>     Signed-off-by: Cedric Hombourger <Cedric_Hombourger@mentor.com
>     <mailto:Cedric_Hombourger@mentor.com>>
>     Cc: Chris Larson <Chris_Larson@mentor.com
>     <mailto:Chris_Larson@mentor.com>>
>     ---
>      lib/bb/fetch2/__init__.py | 7 +++++--
>      1 file changed, 5 insertions(+), 2 deletions(-)
>
>     diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
>     index ca81bd52..e090cd86 100644
>     --- a/lib/bb/fetch2/__init__.py
>     +++ b/lib/bb/fetch2/__init__.py
>     @@ -1026,7 +1026,8 @@ def try_mirror_url(fetch, origud, ud, ld,
>     check = False):
>                          origud.method.build_mirror_data(origud, ld)
>                  return origud.localpath
>              # Otherwise the result is a local file:// and we symlink
>     to it
>     -        ensure_symlink(ud.localpath, origud.localpath)
>     +        ensure_symlink(ud.localpath, origud.localpath, relative=True)
>     +
>              update_stamp(origud, ld)
>              return ud.localpath
>
>     @@ -1060,7 +1061,7 @@ def try_mirror_url(fetch, origud, ud, ld,
>     check = False):
>                  bb.utils.unlockfile(lf)
>
>
>     -def ensure_symlink(target, link_name):
>     +def ensure_symlink(target, link_name, relative=False):
>          if not os.path.exists(link_name):
>              if os.path.islink(link_name):
>                  # Broken symbolic link
>     @@ -1071,6 +1072,8 @@ def ensure_symlink(target, link_name):
>              # same time, in which case we do not want the second task to
>              # fail when the link has already been created by the
>     first task.
>              try:
>     +            if relative is True:
>     +                target = os.path.relpath(target,
>     os.path.dirname(link_name))
>                  os.symlink(target, link_name)
>              except FileExistsError:
>                  pass
>     -- 
>     2.25.1
>
>
>
>
>
> 
>

--------------90217D13E8085BFF0332446F
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 11/27/20 2:54 PM, Martin Jansa
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CA+chaQez30Xyf-e+PDMOa5G-Phb9L8HiEuqhhAHSCJPgudhKdQ@mail.gmail.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <div dir="ltr">Unfortunately this seems to completely break
        SSTATE_MIRROR handling <a class="moz-txt-link-freetext" href="file://">file://</a> at least in some setups.</div>
    </blockquote>
    thank you so much for the feedback. I will check what's wrong there.<br>
    <blockquote type="cite"
cite="mid:CA+chaQez30Xyf-e+PDMOa5G-Phb9L8HiEuqhhAHSCJPgudhKdQ@mail.gmail.com">
      <div dir="ltr">
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
fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz
          in paths:<br>
             
          /jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache<br>
          DEBUG: Defaulting to
/jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache/fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz
          for fb/a4/sstate:python3-ifcfg:cor<br>
texa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz<br>
          DEBUG: Testing URL
<a class="moz-txt-link-freetext" href="file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz;downloadfilename=fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz">file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz;downloadfilename=fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz</a><br>
          DEBUG: For url ['file', '',
'fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz',
          '', '', OrderedDict([('downloadfilename',
'fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz')])]
          comparing ['file', '', '.*', '', '', OrderedDict()] to
          ['file', '',
          '/mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/PATH',
          '', '', OrderedDict()]<br>
          DEBUG: For url
<a class="moz-txt-link-freetext" href="file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz;downloadfilename=fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz">file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz;downloadfilename=fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz</a>
          returning
<a class="moz-txt-link-freetext" href="file:///mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/fb/a4/sstate%3Apython3-ifcfg%3Acortexa72-oe-linux%3A0.21%3Ar0%3Acortexa72%3A3%3Afba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz;downloadfilename=fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz">file:///mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/fb/a4/sstate%3Apython3-ifcfg%3Acortexa72-oe-linux%3A0.21%3Ar0%3Acortexa72%3A3%3Afba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz;downloadfilename=fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz</a><br>
          DEBUG: Trying PREMIRRORS<br>
          DEBUG: For url ['file', '',
'fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz',
          '', '', OrderedDict([('downloadfilename',
'fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz')])]
          comparing ['file', '', '.*', '', '', OrderedDict()] to
          ['file', '',
          '/mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/PATH',
          '', '', OrderedDict()]<br>
          DEBUG: For url
<a class="moz-txt-link-freetext" href="file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz;downloadfilename=fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz">file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz;downloadfilename=fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz</a>
          returning
<a class="moz-txt-link-freetext" href="file:///mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/fb/a4/sstate%3Apython3-ifcfg%3Acortexa72-oe-linux%3A0.21%3Ar0%3Acortexa72%3A3%3Afba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz;downloadfilename=fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz">file:///mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/fb/a4/sstate%3Apython3-ifcfg%3Acortexa72-oe-linux%3A0.21%3Ar0%3Acortexa72%3A3%3Afba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz;downloadfilename=fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz</a><br>
          DEBUG: Searching for
fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo
          in paths:<br>
             
          /jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache<br>
          DEBUG: Defaulting to
/jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache/fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo
          for
fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo<br>
          DEBUG: Testing URL
<a class="moz-txt-link-freetext" href="file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo;downloadfilename=fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo">file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo;downloadfilename=fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo</a><br>
          DEBUG: For url ['file', '',
'fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo',
          '', '', OrderedDict([('downloadfilename',
'fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo')])]
          comparing ['file', '', '.*', '', '', OrderedDict()] to
          ['file', '',
          '/mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/PATH',
          '', '', OrderedDict()]<br>
          DEBUG: For url
<a class="moz-txt-link-freetext" href="file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo;downloadfilename=fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo">file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo;downloadfilename=fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo</a>
          returning
<a class="moz-txt-link-freetext" href="file:///mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/fb/a4/sstate%3Apython3-ifcfg%3Acortexa72-oe-linux%3A0.21%3Ar0%3Acortexa72%3A3%3Afba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo;downloadfilename=fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo">file:///mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/fb/a4/sstate%3Apython3-ifcfg%3Acortexa72-oe-linux%3A0.21%3Ar0%3Acortexa72%3A3%3Afba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo;downloadfilename=fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo</a><br>
          DEBUG: Trying PREMIRRORS<br>
          DEBUG: For url ['file', '',
'fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo',
          '', '', OrderedDict([('downloadfilename',
'fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo')])]
          comparing ['file', '', '.*', '', '', OrderedDict()] to
          ['file', '',
          '/mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/PATH',
          '', '', OrderedDict()]<br>
          DEBUG: For url
<a class="moz-txt-link-freetext" href="file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo;downloadfilename=fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo">file://fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo;downloadfilename=fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo</a>
          returning
<a class="moz-txt-link-freetext" href="file:///mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/fb/a4/sstate%3Apython3-ifcfg%3Acortexa72-oe-linux%3A0.21%3Ar0%3Acortexa72%3A3%3Afba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo;downloadfilename=fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo">file:///mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/fb/a4/sstate%3Apython3-ifcfg%3Acortexa72-oe-linux%3A0.21%3Ar0%3Acortexa72%3A3%3Afba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo;downloadfilename=fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz.siginfo</a><br>
          NOTE: Sstate package
/jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache/fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz
          does not exist<br>
          ERROR: No suitable staging package found<br>
          DEBUG: Python function do_package_qa_setscene finished</div>
        <div><br>
        </div>
        <div>$ ls -lah
"/jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache/fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz"<br>
          lrwxrwxrwx 1 mjansa mjansa 229 Nov 27 05:41
/jenkins/mjansa/build/ros/ros2-rolling-hardknott/sstate-cache/fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz
          -&gt;
../../../../../../../../mnt/mirror-write-ros/jansa/webos/ros-hardknott/sstate-cache/fb/a4/sstate:python3-ifcfg:cortexa72-oe-linux:0.21:r0:cortexa72:3:fba4a512f137dced352b65244a828d6014453f4f3899c45b178a7cbcf8b5d8b2_package_qa.tgz<br>
          <div><br>
          </div>
          <div><br>
          </div>
        </div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Wed, Nov 18, 2020 at 4:36
          PM Hombourger, Cedric &lt;<a
            href="mailto:Cedric_Hombourger@mentor.com"
            moz-do-not-send="true">Cedric_Hombourger@mentor.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">try_mirror_url()
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
          take an optional "relative" argument and have that function
          use<br>
          os.path.relpath() to produce a relative symlink.<br>
          <br>
          Signed-off-by: Cedric Hombourger &lt;<a
            href="mailto:Cedric_Hombourger@mentor.com" target="_blank"
            moz-do-not-send="true">Cedric_Hombourger@mentor.com</a>&gt;<br>
          Cc: Chris Larson &lt;<a href="mailto:Chris_Larson@mentor.com"
            target="_blank" moz-do-not-send="true">Chris_Larson@mentor.com</a>&gt;<br>
          ---<br>
           lib/bb/fetch2/__init__.py | 7 +++++--<br>
           1 file changed, 5 insertions(+), 2 deletions(-)<br>
          <br>
          diff --git a/lib/bb/fetch2/__init__.py
          b/lib/bb/fetch2/__init__.py<br>
          index ca81bd52..e090cd86 100644<br>
          --- a/lib/bb/fetch2/__init__.py<br>
          +++ b/lib/bb/fetch2/__init__.py<br>
          @@ -1026,7 +1026,8 @@ def try_mirror_url(fetch, origud, ud,
          ld, check = False):<br>
                               origud.method.build_mirror_data(origud,
          ld)<br>
                       return origud.localpath<br>
                   # Otherwise the result is a local <a class="moz-txt-link-freetext" href="file://">file://</a> and we
          symlink to it<br>
          -        ensure_symlink(ud.localpath, origud.localpath)<br>
          +        ensure_symlink(ud.localpath, origud.localpath,
          relative=True)<br>
          +<br>
                   update_stamp(origud, ld)<br>
                   return ud.localpath<br>
          <br>
          @@ -1060,7 +1061,7 @@ def try_mirror_url(fetch, origud, ud,
          ld, check = False):<br>
                       bb.utils.unlockfile(lf)<br>
          <br>
          <br>
          -def ensure_symlink(target, link_name):<br>
          +def ensure_symlink(target, link_name, relative=False):<br>
               if not os.path.exists(link_name):<br>
                   if os.path.islink(link_name):<br>
                       # Broken symbolic link<br>
          @@ -1071,6 +1072,8 @@ def ensure_symlink(target, link_name):<br>
                   # same time, in which case we do not want the second
          task to<br>
                   # fail when the link has already been created by the
          first task.<br>
                   try:<br>
          +            if relative is True:<br>
          +                target = os.path.relpath(target,
          os.path.dirname(link_name))<br>
                       os.symlink(target, link_name)<br>
                   except FileExistsError:<br>
                       pass<br>
          -- <br>
          2.25.1<br>
          <br>
          <br>
          <br>
          <br>
        </blockquote>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">


</pre>
    </blockquote>
  </body>
</html>

--------------90217D13E8085BFF0332446F--
