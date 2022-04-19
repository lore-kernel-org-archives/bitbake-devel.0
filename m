Return-Path: <amikan@ilbers.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5B6C43219
	for <webhook@archiver.kernel.org>; Tue, 19 Apr 2022 14:22:18 +0000 (UTC)
Received: from shymkent.ilbers.de (shymkent.ilbers.de [85.214.156.166])
 by mx.groups.io with SMTP id smtpd.web09.1385.1650351057414014137
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Apr 2022 23:50:57 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: ilbers.de, ip: 85.214.156.166, mailfrom: amikan@ilbers.de)
Received: from [127.0.0.1] (host-80-81-17-52.static.customer.m-online.net
 [80.81.17.52])
	(authenticated bits=0)
	by shymkent.ilbers.de (8.15.2/8.15.2/Debian-8) with ESMTPSA id 23J6oqu9025593
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Apr 2022 08:50:54 +0200
Content-Type: multipart/alternative;
 boundary="------------iibqDxqgh0HRTF0lb8QE3Mbp"
Message-ID: <065ce2a8-1360-10d0-c085-4677206280d3@ilbers.de>
Date: Tue, 19 Apr 2022 09:50:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: bitbake-devel@lists.openembedded.org
From: Anton Mikanovich <amikan@ilbers.de>
Subject: Segmentation fault logging during task execution
Cc: Baurzhan Ismagulov <ibr@ilbers.de>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 Apr 2022 14:22:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13639

This is a multi-part message in MIME format.
--------------iibqDxqgh0HRTF0lb8QE3Mbp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by shymkent.ilbers.de id
 23J6oqu9025593

Hello,
If running bitbake on some task with default params like:

$ bitbake mc:multiconfig-target:somerecipe:do_test

Where do_test task looks like:

do_test() {
 =C2=A0=C2=A0=C2=A0 some_segfaulting_app
}
addtask test

All the logs, both stdout and stderr got mixed by _logged_communicate()=20
and placed into log.do_test.
If segfault happens those logs are printed in console stdout from the log.

Because of that we have some unobvious error handling behavior:

$ bitbake mc:multiconfig-target:somerecipe:do_test >/dev/null
will not print 'Segmentation fault' stderr message happened during=20
execution.

Is that expected behavior of bitbake?

--------------iibqDxqgh0HRTF0lb8QE3Mbp
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by shymkent.ilbers.de id
 23J6oqu9025593

<html>
  <head>

    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    <p>Hello,<br>
      If running bitbake on some task with default params like:<br>
      <br>
      $ bitbake mc:multiconfig-target:somerecipe:do_test<br>
      <br>
      Where do_test task looks like:<br>
      <br>
      do_test() {<br>
      =C2=A0=C2=A0=C2=A0 some_segfaulting_app<br>
      }<br>
      addtask test<br>
      <br>
      All the logs, both stdout and stderr got mixed by
      _logged_communicate() and placed into log.do_test.<br>
      If segfault happens those logs are printed in console stdout from
      the log.<br>
      <br>
      Because of that we have some <span class=3D"VIiyi" lang=3D"en"><spa=
n
          class=3D"JLqJ4b ChMk0b" data-language-for-alternatives=3D"en"
          data-language-to-translate-into=3D"ru" data-phrase-index=3D"0"
          data-number-of-phrases=3D"1"><span class=3D"Q4iAWc">unobvious
            error handling behavior:<br>
            <br>
            $ </span></span></span><span class=3D"VIiyi" lang=3D"en"><spa=
n
          class=3D"JLqJ4b ChMk0b" data-language-for-alternatives=3D"en"
          data-language-to-translate-into=3D"ru" data-phrase-index=3D"0"
          data-number-of-phrases=3D"1"><span class=3D"Q4iAWc">bitbake
            mc:multiconfig-target:somerecipe:do_test &gt;/dev/null<br>
            will not print 'Segmentation fault' stderr message happened
            during execution.<br>
            <br>
            Is that </span></span></span><span class=3D"VIiyi" lang=3D"en=
"><span
          class=3D"JLqJ4b ChMk0b" data-language-for-alternatives=3D"en"
          data-language-to-translate-into=3D"ru" data-phrase-index=3D"0"
          data-number-of-phrases=3D"1"><span class=3D"Q4iAWc"><span
              class=3D"VIiyi" lang=3D"en"><span class=3D"JLqJ4b ChMk0b"
                data-language-for-alternatives=3D"en"
                data-language-to-translate-into=3D"ru"
                data-phrase-index=3D"0" data-number-of-phrases=3D"1"><spa=
n
                  class=3D"Q4iAWc">expected behavior of bitbake?</span></=
span></span></span></span></span></p>
  </body>
</html>

--------------iibqDxqgh0HRTF0lb8QE3Mbp--

