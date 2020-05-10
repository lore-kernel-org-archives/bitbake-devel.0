Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
 by mx.groups.io with SMTP id smtpd.web11.17394.1589126771924819304
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 10 May 2020 09:06:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=HGs5YPYO;
 spf=pass (domain: gmail.com, ip: 209.85.215.196, mailfrom: akuster808@gmail.com)
Received: by mail-pg1-f196.google.com with SMTP id j21so3338097pgb.7
        for <bitbake-devel@lists.openembedded.org>; Sun, 10 May 2020 09:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:autocrypt:message-id:date:user-agent:mime-version
         :content-language;
        bh=syNbB0HhxGzSkRMP5rK32+FNhggHgqHR+cUoPZ7wskA=;
        b=HGs5YPYO5OPEfDRwLBUMBbvWiURb1GlRgt1JznomfFPwi+s2uC9DJWRoPFRANw8aMU
         UGz4eAjlJdz+j+Kov8GXoGc7mpJokldll+6ezuGFcQyULYk5lBnRkw6l7S+MllsuuJhU
         MahUk3GNwX1+t4SiBS59rkRpyglc4c502GxvcRmkhysYgfDemTCyjSm/t1vEKxum3KZb
         ooKAFDLBGrB08dFCoP5b4Clhccb9sfnHCQ2bz4vM3wG+xBymQ6dOcf9CQiMKwsExflHd
         UWixmW/+7z6dXgMg15KWBERq2PUsU8LovrJQNCiDuHlJ7Y3oWC4ySFhAmhm3uoj+g25l
         uwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:autocrypt:message-id:date
         :user-agent:mime-version:content-language;
        bh=syNbB0HhxGzSkRMP5rK32+FNhggHgqHR+cUoPZ7wskA=;
        b=F+1GtvTqND2g3gOjFkI1DzwAgR6c8U8zuFbTqP+YIya1IeHv3+V1kgY5xmHtTKvfIs
         OrkPyF2I6mX773NUOvuXZ2uEOIPobXFkn/YoV3XvKnXObb1GYaCVa75gzorOWLMYzwpc
         /ndRIczNPuah5Susaz08G9CVSm4SR+AumMyCbGF5M3BHqrDDP85pgR7Crcr4HRupFqtK
         POU5rFT/nc5UeOwRyuCwa4eriDNMtJ8RM4y/30iApdSLwbOOCgclkC8OJoDDb2hhk4Ec
         JtJSwBJc7pMAzrG2i55dP3IJ+FwHgHCaaWHyxcCaQ4ObHDbP3Mnhf3iq3n4y52kBeMLT
         kG0w==
X-Gm-Message-State: AOAM530xAve2QSZEPnYGfMoIrHRE7MbyhCxjuCKGVFzwyYcijsBwdt6d
	ZMcUvb3F+73SAYO1Lpn5RW8SNgs7
X-Google-Smtp-Source: ABdhPJxzpiwJZjK6QBPjClnv8ACR0rl2/q8c7mJIbpBib89Rv9JfBpyDCGceTmaO+KwqgvyrKVhbrA==
X-Received: by 2002:a63:33c6:: with SMTP id z189mr236397pgz.357.1589126771021;
        Sun, 10 May 2020 09:06:11 -0700 (PDT)
Return-Path: <akuster808@gmail.com>
Received: from ?IPv6:2601:202:4180:a5c0:5144:7d75:d840:ce3d? ([2601:202:4180:a5c0:5144:7d75:d840:ce3d])
        by smtp.gmail.com with ESMTPSA id b29sm7057888pfp.68.2020.05.10.09.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2020 09:06:10 -0700 (PDT)
To: "openembedded-core@openembedded.org"
 <openembedded-core@openembedded.org>,
 "yocto@yoctoproject.org" <yocto@yoctoproject.org>,
 "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
From: "akuster" <akuster808@gmail.com>
Subject: 3.2 (Gatesgarth ) assistance
Autocrypt: addr=akuster808@gmail.com; prefer-encrypt=mutual; keydata=
 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
 8CS2NxU=
Message-ID: <702d984e-3f98-6513-ea4d-e0811ce232d9@gmail.com>
Date: Sun, 10 May 2020 09:06:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------C49D921B093592FFB9BFF045"
Content-Language: en-US

--------------C49D921B093592FFB9BFF045
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

The Yocto Project and OE bug triage are seeking some assistance on tasks
we hope to addressed into 3.2.

The first milestone for 3.2 is targeted for 2020/6/16.=C2=A0=C2=A0 If any=
one is
interested in helping or seeking a new=C2=A0 challenge, please=C2=A0 take=
 a look
in the list below to see if anything interests you. Help can be in any
form from research to a patch to address the issue.

Best regards,
Armin
(On behalf of the Yocto Project triage team)



https://wiki.yoctoproject.org/wiki/Bug_Triage#Medium.2B_3.2_Unassigned_En=
hancements.2FBugs


5389 <https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D5389>
bitbake/lib/bb/fetch2: filename too long 	normal 	Medium+ 	3.2 M1
Unassigned 	IN PROGRESS IMPLEMENTATION =09
	4
7600 <https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D7600> 	syslinux=
:
port extX support patches to syslinux community 	enhancement 	Medium+
3.2 M1 	Unassigned 	IN PROGRESS IMPLEMENTATION =09
	5
10731 <https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D10731> 	bitbak=
e
--observe-only doesn't work with memres 	normal 	Medium+ 	3.2 M1
Unassigned 	IN PROGRESS REVIEW =09
	5
11351 <https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D11351>
go-native: do_compile failed when len(tmp) =3D 410 	normal 	Medium+ 	3.2
M1 	Unassigned 	NEW =09
	2
11781 <https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D11781> 	bitbak=
e
--observe-only may get KeyError 	normal 	Medium+ 	3.2 M1 	Unassigned 	IN
PROGRESS REVIEW =09
	3
12347 <https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D12347>
llvm-native: do_configure failed when len(TMPDIR) =3D=3D 410 	normal
Medium+ 	3.2 M1 	Unassigned 	NEW =09
	2
12362 <https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D12362>
webkitgtk: do_compile failed when len(TMPDIR) =3D=3D 410 	normal 	Medium+=

3.2 M1 	Unassigned 	NEW =09
	3
12367 <https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D12367> 	moving=

or removing tmp breaks persistent bitbake server 	normal 	Medium+ 	3.2
M1 	Unassigned 	NEW =09
=09
12374 <https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D12374>
do_rootfs failed when len(TMPDIR) =3D=3D 410 	normal 	Medium+ 	3.2 M1
Unassigned 	NEW =09
	2
13004 <https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D13004>
Automate yocto-check-layer -m option 	enhancement 	Medium+ 	3.2 M1
Unassigned 	NEW =09
=09
13023 <https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D13023> 	Switch=

to memory resident bitbake by default in 3.2 	enhancement 	Medium+ 	3.2
M1 	Unassigned 	NEW =09
=09
13039 <https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D13039> 	fetch2=
:
PREMIRROR and SRC_URI with type https and parameter downloadfilename
yields invalid url 	normal 	Medium+ 	3.2 M1 	Unassigned 	NEW =09
=09
13055 <https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D13055>
oe-selftest runcmd.RunCmdTests.test_stdin failure 	normal 	Medium+ 	3.2
M1 	Unassigned 	NEW =09
=09
13176 <https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D13176>
yocto-check-layer can only check layers which aren't already in BBLAYERS
	normal 	Medium+ 	3.2 M1 	Unassigned 	NEW 	Backport 3.1 & 3.0 & 2.7 =09
13181 <https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D13181>
persist_data sqlite database mixed with forking is irreparably broken
normal 	Medium+ 	3.2 M1 	Unassigned 	NEW =09
=09
13233 <https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D13233> 	fetch2=
:
try_premirror(): improve on updating repo from mirror 	enhancement
Medium+ 	3.2 M1 	Unassigned 	NEW =09
	3
13236 <https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D13236> 	sstate=

for host native packages 	normal 	Medium+ 	3.2 M1 	Unassigned 	NEW =09
=09
13279 <https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D13279> 	Make
sure users/groups exist for package_write_* tasks 	normal 	Medium+ 	3.2
M1 	Unassigned 	NEW =09
=09
13306 <https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D13306> 	bitbak=
e
starts up to n^2 processes with n cpus 	normal 	Medium+ 	3.2 M1
Unassigned 	NEW =09
=09
13353 <https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D13353> 	bitbak=
e
git fetcher does not honour BB_FETCH_PREMIRRORONLY 	normal 	Medium+ 	3.2
M1 	Unassigned 	NEW =09
=09
13419 <https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D13419> 	recipe=
s
that add users to groups cannot rely on other recipes creating those
groups (when population from sstate happens) 	normal 	Medium+ 	3.2 M1
Unassigned 	NEW =09
=09
13421 <https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D13421> 	File
race when calling devtool.setUpModule 	normal 	Medium+ 	3.2 M1
Unassigned 	NEW =09
=09
13463 <https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D13463> 	test
linux-yocto-rt kernels too 	normal 	Medium+ 	3.2 M1 	Unassigned 	NEW =09
=09
13705 <https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D13705> 	master=
]
bitbake and hashserve.sock left behind when ^C a build 	normal 	Medium+
3.2 M1 	Unassigned 	NEW =09
=09
13803 <https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D13803> 	devtoo=
l
setupClass file copying race 	normal 	Medium+ 	3.2 M1 	Unassigned 	NEW
backport 3.1 =09
13811 <https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D13811> 	Memory=

Resident bitbake has output redirection problem 	normal 	Medium+ 	3.2 M1
	Unassigned 	NEW =09
=09
13843 <https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D13843> 	bitbak=
e
worker stuck using 100% cpu on aborted build 	normal 	Medium+ 	3.2 M1
Unassigned 	NEW =09
=09
13859 <https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D13859>
adwaita-icon-theme cannot find GTK+3 gtk-update-icon-cache command
minor 	Medium+ 	3.2 M1 	Unassigned 	NEW =09
=09
13868 <https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D13868> 	Python=

cache files get lost in packages 	normal 	Medium+ 	3.2 M1 	Unassigned 	NE=
W =09
=09
13822 <https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D13822> 	Easy t=
o
have misleading warnings if env script is executed instead of sourced
normal 	Medium+ 	3.2 M2 	Unassigned


--------------C49D921B093592FFB9BFF045
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Hello,<br>
    <br>
    The Yocto Project and OE bug triage are seeking some assistance on
    tasks we hope to addressed into 3.2.<br>
    <br>
    The first milestone for 3.2 is targeted for <span
      style="font-family:&quot;Arial&quot;,sans-serif">2020/6/16.   If
      anyone is interested in helping or seeking a new  challenge,
      please  take a look in the list below to see if anything interests
      you. Help can be in any form from research to a patch to address
      the issue.<br>
      <br>
      Best regards,<br>
      Armin<br>
      (On behalf of the Yocto Project triage team)<br>
      <br>
      <br>
      <br>
<a class="moz-txt-link-freetext" href="https://wiki.yoctoproject.org/wiki/Bug_Triage#Medium.2B_3.2_Unassigned_Enhancements.2FBugs">https://wiki.yoctoproject.org/wiki/Bug_Triage#Medium.2B_3.2_Unassigned_Enhancements.2FBugs</a><br>
      <br>
    </span><br>
    <table class="bugzilla sortable">
      <tbody>
        <tr class="bz_bug Medium+ normal IN PROGRESS IMPLEMENTATION
          bz_row_odd">
          <td title="5389"><a
              href="https://bugzilla.yoctoproject.org/show_bug.cgi?id=5389"
              class="extiw" title="bugzilla:5389"><span title="5389">5389</span></a></td>
          <td>bitbake/lib/bb/fetch2: filename too long</td>
          <td>normal</td>
          <td>Medium+</td>
          <td>3.2 M1</td>
          <td>Unassigned</td>
          <td>IN PROGRESS IMPLEMENTATION</td>
          <td><br>
          </td>
          <td>4</td>
        </tr>
        <tr class="bz_bug Medium+ enhancement IN PROGRESS IMPLEMENTATION
          bz_row_even">
          <td title="7600"><a
              href="https://bugzilla.yoctoproject.org/show_bug.cgi?id=7600"
              class="extiw" title="bugzilla:7600"><span title="7600">7600</span></a></td>
          <td>syslinux: port extX support patches to syslinux community</td>
          <td>enhancement</td>
          <td>Medium+</td>
          <td>3.2 M1</td>
          <td>Unassigned</td>
          <td>IN PROGRESS IMPLEMENTATION</td>
          <td><br>
          </td>
          <td>5</td>
        </tr>
        <tr class="bz_bug Medium+ normal IN PROGRESS REVIEW bz_row_odd">
          <td title="10731"><a
              href="https://bugzilla.yoctoproject.org/show_bug.cgi?id=10731"
              class="extiw" title="bugzilla:10731"><span title="10731">10731</span></a></td>
          <td>bitbake --observe-only doesn't work with memres</td>
          <td>normal</td>
          <td>Medium+</td>
          <td>3.2 M1</td>
          <td>Unassigned</td>
          <td>IN PROGRESS REVIEW</td>
          <td><br>
          </td>
          <td>5</td>
        </tr>
        <tr class="bz_bug Medium+ normal NEW bz_row_even">
          <td title="11351"><a
              href="https://bugzilla.yoctoproject.org/show_bug.cgi?id=11351"
              class="extiw" title="bugzilla:11351"><span title="11351">11351</span></a></td>
          <td>go-native: do_compile failed when len(tmp) = 410</td>
          <td>normal</td>
          <td>Medium+</td>
          <td>3.2 M1</td>
          <td>Unassigned</td>
          <td>NEW</td>
          <td><br>
          </td>
          <td>2</td>
        </tr>
        <tr class="bz_bug Medium+ normal IN PROGRESS REVIEW bz_row_odd">
          <td title="11781"><a
              href="https://bugzilla.yoctoproject.org/show_bug.cgi?id=11781"
              class="extiw" title="bugzilla:11781"><span title="11781">11781</span></a></td>
          <td>bitbake --observe-only may get KeyError</td>
          <td>normal</td>
          <td>Medium+</td>
          <td>3.2 M1</td>
          <td>Unassigned</td>
          <td>IN PROGRESS REVIEW</td>
          <td><br>
          </td>
          <td>3</td>
        </tr>
        <tr class="bz_bug Medium+ normal NEW bz_row_even">
          <td title="12347"><a
              href="https://bugzilla.yoctoproject.org/show_bug.cgi?id=12347"
              class="extiw" title="bugzilla:12347"><span title="12347">12347</span></a></td>
          <td>llvm-native: do_configure failed when len(TMPDIR) == 410</td>
          <td>normal</td>
          <td>Medium+</td>
          <td>3.2 M1</td>
          <td>Unassigned</td>
          <td>NEW</td>
          <td><br>
          </td>
          <td>2</td>
        </tr>
        <tr class="bz_bug Medium+ normal NEW bz_row_odd">
          <td title="12362"><a
              href="https://bugzilla.yoctoproject.org/show_bug.cgi?id=12362"
              class="extiw" title="bugzilla:12362"><span title="12362">12362</span></a></td>
          <td>webkitgtk: do_compile failed when len(TMPDIR) == 410</td>
          <td>normal</td>
          <td>Medium+</td>
          <td>3.2 M1</td>
          <td>Unassigned</td>
          <td>NEW</td>
          <td><br>
          </td>
          <td>3</td>
        </tr>
        <tr class="bz_bug Medium+ normal NEW bz_row_even">
          <td title="12367"><a
              href="https://bugzilla.yoctoproject.org/show_bug.cgi?id=12367"
              class="extiw" title="bugzilla:12367"><span title="12367">12367</span></a></td>
          <td>moving or removing tmp breaks persistent bitbake server</td>
          <td>normal</td>
          <td>Medium+</td>
          <td>3.2 M1</td>
          <td>Unassigned</td>
          <td>NEW</td>
          <td><br>
          </td>
          <td><br>
          </td>
        </tr>
        <tr class="bz_bug Medium+ normal NEW bz_row_odd">
          <td title="12374"><a
              href="https://bugzilla.yoctoproject.org/show_bug.cgi?id=12374"
              class="extiw" title="bugzilla:12374"><span title="12374">12374</span></a></td>
          <td>do_rootfs failed when len(TMPDIR) == 410</td>
          <td>normal</td>
          <td>Medium+</td>
          <td>3.2 M1</td>
          <td>Unassigned</td>
          <td>NEW</td>
          <td><br>
          </td>
          <td>2</td>
        </tr>
        <tr class="bz_bug Medium+ enhancement NEW bz_row_even">
          <td title="13004"><a
              href="https://bugzilla.yoctoproject.org/show_bug.cgi?id=13004"
              class="extiw" title="bugzilla:13004"><span title="13004">13004</span></a></td>
          <td>Automate yocto-check-layer -m option</td>
          <td>enhancement</td>
          <td>Medium+</td>
          <td>3.2 M1</td>
          <td>Unassigned</td>
          <td>NEW</td>
          <td><br>
          </td>
          <td><br>
          </td>
        </tr>
        <tr class="bz_bug Medium+ enhancement NEW bz_row_odd">
          <td title="13023"><a
              href="https://bugzilla.yoctoproject.org/show_bug.cgi?id=13023"
              class="extiw" title="bugzilla:13023"><span title="13023">13023</span></a></td>
          <td>Switch to memory resident bitbake by default in 3.2</td>
          <td>enhancement</td>
          <td>Medium+</td>
          <td>3.2 M1</td>
          <td>Unassigned</td>
          <td>NEW</td>
          <td><br>
          </td>
          <td><br>
          </td>
        </tr>
        <tr class="bz_bug Medium+ normal NEW bz_row_even">
          <td title="13039"><a
              href="https://bugzilla.yoctoproject.org/show_bug.cgi?id=13039"
              class="extiw" title="bugzilla:13039"><span title="13039">13039</span></a></td>
          <td>fetch2: PREMIRROR and SRC_URI with type https and
            parameter downloadfilename yields invalid url</td>
          <td>normal</td>
          <td>Medium+</td>
          <td>3.2 M1</td>
          <td>Unassigned</td>
          <td>NEW</td>
          <td><br>
          </td>
          <td><br>
          </td>
        </tr>
        <tr class="bz_bug Medium+ normal NEW bz_row_odd">
          <td title="13055"><a
              href="https://bugzilla.yoctoproject.org/show_bug.cgi?id=13055"
              class="extiw" title="bugzilla:13055"><span title="13055">13055</span></a></td>
          <td>oe-selftest runcmd.RunCmdTests.test_stdin failure</td>
          <td>normal</td>
          <td>Medium+</td>
          <td>3.2 M1</td>
          <td>Unassigned</td>
          <td>NEW</td>
          <td><br>
          </td>
          <td><br>
          </td>
        </tr>
        <tr class="bz_bug Medium+ normal NEW bz_row_even">
          <td title="13176"><a
              href="https://bugzilla.yoctoproject.org/show_bug.cgi?id=13176"
              class="extiw" title="bugzilla:13176"><span title="13176">13176</span></a></td>
          <td>yocto-check-layer can only check layers which aren't
            already in BBLAYERS</td>
          <td>normal</td>
          <td>Medium+</td>
          <td>3.2 M1</td>
          <td>Unassigned</td>
          <td>NEW</td>
          <td>Backport 3.1 &amp; 3.0 &amp; 2.7</td>
          <td><br>
          </td>
        </tr>
        <tr class="bz_bug Medium+ normal NEW bz_row_odd">
          <td title="13181"><a
              href="https://bugzilla.yoctoproject.org/show_bug.cgi?id=13181"
              class="extiw" title="bugzilla:13181"><span title="13181">13181</span></a></td>
          <td>persist_data sqlite database mixed with forking is
            irreparably broken</td>
          <td>normal</td>
          <td>Medium+</td>
          <td>3.2 M1</td>
          <td>Unassigned</td>
          <td>NEW</td>
          <td><br>
          </td>
          <td><br>
          </td>
        </tr>
        <tr class="bz_bug Medium+ enhancement NEW bz_row_even">
          <td title="13233"><a
              href="https://bugzilla.yoctoproject.org/show_bug.cgi?id=13233"
              class="extiw" title="bugzilla:13233"><span title="13233">13233</span></a></td>
          <td>fetch2: try_premirror(): improve on updating repo from
            mirror</td>
          <td>enhancement</td>
          <td>Medium+</td>
          <td>3.2 M1</td>
          <td>Unassigned</td>
          <td>NEW</td>
          <td><br>
          </td>
          <td>3</td>
        </tr>
        <tr class="bz_bug Medium+ normal NEW bz_row_odd">
          <td title="13236"><a
              href="https://bugzilla.yoctoproject.org/show_bug.cgi?id=13236"
              class="extiw" title="bugzilla:13236"><span title="13236">13236</span></a></td>
          <td>sstate for host native packages</td>
          <td>normal</td>
          <td>Medium+</td>
          <td>3.2 M1</td>
          <td>Unassigned</td>
          <td>NEW</td>
          <td><br>
          </td>
          <td><br>
          </td>
        </tr>
        <tr class="bz_bug Medium+ normal NEW bz_row_even">
          <td title="13279"><a
              href="https://bugzilla.yoctoproject.org/show_bug.cgi?id=13279"
              class="extiw" title="bugzilla:13279"><span title="13279">13279</span></a></td>
          <td>Make sure users/groups exist for package_write_* tasks</td>
          <td>normal</td>
          <td>Medium+</td>
          <td>3.2 M1</td>
          <td>Unassigned</td>
          <td>NEW</td>
          <td><br>
          </td>
          <td><br>
          </td>
        </tr>
        <tr class="bz_bug Medium+ normal NEW bz_row_odd">
          <td title="13306"><a
              href="https://bugzilla.yoctoproject.org/show_bug.cgi?id=13306"
              class="extiw" title="bugzilla:13306"><span title="13306">13306</span></a></td>
          <td>bitbake starts up to n^2 processes with n cpus</td>
          <td>normal</td>
          <td>Medium+</td>
          <td>3.2 M1</td>
          <td>Unassigned</td>
          <td>NEW</td>
          <td><br>
          </td>
          <td><br>
          </td>
        </tr>
        <tr class="bz_bug Medium+ normal NEW bz_row_even">
          <td title="13353"><a
              href="https://bugzilla.yoctoproject.org/show_bug.cgi?id=13353"
              class="extiw" title="bugzilla:13353"><span title="13353">13353</span></a></td>
          <td>bitbake git fetcher does not honour BB_FETCH_PREMIRRORONLY</td>
          <td>normal</td>
          <td>Medium+</td>
          <td>3.2 M1</td>
          <td>Unassigned</td>
          <td>NEW</td>
          <td><br>
          </td>
          <td><br>
          </td>
        </tr>
        <tr class="bz_bug Medium+ normal NEW bz_row_odd">
          <td title="13419"><a
              href="https://bugzilla.yoctoproject.org/show_bug.cgi?id=13419"
              class="extiw" title="bugzilla:13419"><span title="13419">13419</span></a></td>
          <td>recipes that add users to groups cannot rely on other
            recipes creating those groups (when population from sstate
            happens)</td>
          <td>normal</td>
          <td>Medium+</td>
          <td>3.2 M1</td>
          <td>Unassigned</td>
          <td>NEW</td>
          <td><br>
          </td>
          <td><br>
          </td>
        </tr>
        <tr class="bz_bug Medium+ normal NEW bz_row_even">
          <td title="13421"><a
              href="https://bugzilla.yoctoproject.org/show_bug.cgi?id=13421"
              class="extiw" title="bugzilla:13421"><span title="13421">13421</span></a></td>
          <td>File race when calling devtool.setUpModule</td>
          <td>normal</td>
          <td>Medium+</td>
          <td>3.2 M1</td>
          <td>Unassigned</td>
          <td>NEW</td>
          <td><br>
          </td>
          <td><br>
          </td>
        </tr>
        <tr class="bz_bug Medium+ normal NEW bz_row_odd">
          <td title="13463"><a
              href="https://bugzilla.yoctoproject.org/show_bug.cgi?id=13463"
              class="extiw" title="bugzilla:13463"><span title="13463">13463</span></a></td>
          <td>test linux-yocto-rt kernels too</td>
          <td>normal</td>
          <td>Medium+</td>
          <td>3.2 M1</td>
          <td>Unassigned</td>
          <td>NEW</td>
          <td><br>
          </td>
          <td><br>
          </td>
        </tr>
        <tr class="bz_bug Medium+ normal NEW bz_row_even">
          <td title="13705"><a
              href="https://bugzilla.yoctoproject.org/show_bug.cgi?id=13705"
              class="extiw" title="bugzilla:13705"><span title="13705">13705</span></a></td>
          <td>master] bitbake and hashserve.sock left behind when ^C a
            build</td>
          <td>normal</td>
          <td>Medium+</td>
          <td>3.2 M1</td>
          <td>Unassigned</td>
          <td>NEW</td>
          <td><br>
          </td>
          <td><br>
          </td>
        </tr>
        <tr class="bz_bug Medium+ normal NEW bz_row_odd">
          <td title="13803"><a
              href="https://bugzilla.yoctoproject.org/show_bug.cgi?id=13803"
              class="extiw" title="bugzilla:13803"><span title="13803">13803</span></a></td>
          <td>devtool setupClass file copying race</td>
          <td>normal</td>
          <td>Medium+</td>
          <td>3.2 M1</td>
          <td>Unassigned</td>
          <td>NEW</td>
          <td>backport 3.1</td>
          <td><br>
          </td>
        </tr>
        <tr class="bz_bug Medium+ normal NEW bz_row_even">
          <td title="13811"><a
              href="https://bugzilla.yoctoproject.org/show_bug.cgi?id=13811"
              class="extiw" title="bugzilla:13811"><span title="13811">13811</span></a></td>
          <td>Memory Resident bitbake has output redirection problem</td>
          <td>normal</td>
          <td>Medium+</td>
          <td>3.2 M1</td>
          <td>Unassigned</td>
          <td>NEW</td>
          <td><br>
          </td>
          <td><br>
          </td>
        </tr>
        <tr class="bz_bug Medium+ normal NEW bz_row_odd">
          <td title="13843"><a
              href="https://bugzilla.yoctoproject.org/show_bug.cgi?id=13843"
              class="extiw" title="bugzilla:13843"><span title="13843">13843</span></a></td>
          <td>bitbake worker stuck using 100% cpu on aborted build</td>
          <td>normal</td>
          <td>Medium+</td>
          <td>3.2 M1</td>
          <td>Unassigned</td>
          <td>NEW</td>
          <td><br>
          </td>
          <td><br>
          </td>
        </tr>
        <tr class="bz_bug Medium+ minor NEW bz_row_even">
          <td title="13859"><a
              href="https://bugzilla.yoctoproject.org/show_bug.cgi?id=13859"
              class="extiw" title="bugzilla:13859"><span title="13859">13859</span></a></td>
          <td>adwaita-icon-theme cannot find GTK+3 gtk-update-icon-cache
            command</td>
          <td>minor</td>
          <td>Medium+</td>
          <td>3.2 M1</td>
          <td>Unassigned</td>
          <td>NEW</td>
          <td><br>
          </td>
          <td><br>
          </td>
        </tr>
        <tr class="bz_bug Medium+ normal NEW bz_row_odd">
          <td title="13868"><a
              href="https://bugzilla.yoctoproject.org/show_bug.cgi?id=13868"
              class="extiw" title="bugzilla:13868"><span title="13868">13868</span></a></td>
          <td>Python cache files get lost in packages</td>
          <td>normal</td>
          <td>Medium+</td>
          <td>3.2 M1</td>
          <td>Unassigned</td>
          <td>NEW</td>
          <td><br>
          </td>
          <td><br>
          </td>
        </tr>
        <tr class="bz_bug Medium+ normal NEW bz_row_even">
          <td title="13822"><a
              href="https://bugzilla.yoctoproject.org/show_bug.cgi?id=13822"
              class="extiw" title="bugzilla:13822"><span title="13822">13822</span></a></td>
          <td>Easy to have misleading warnings if env script is executed
            instead of sourced</td>
          <td>normal</td>
          <td>Medium+</td>
          <td>3.2 M2</td>
          <td>Unassigned</td>
        </tr>
      </tbody>
    </table>
    <span style="font-family:&quot;Arial&quot;,sans-serif"></span>
  </body>
</html>

--------------C49D921B093592FFB9BFF045--
