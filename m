Received: from MTA-11-4.privateemail.com (MTA-11-4.privateemail.com [198.54.127.104])
 by mx.groups.io with SMTP id smtpd.web12.36370.1601907732167986853
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 05 Oct 2020 07:22:12 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: whitetree.xyz, ip: 198.54.127.104, mailfrom: charles.davies@whitetree.xyz)
Received: from mta-11.privateemail.com (localhost [127.0.0.1])
	by mta-11.privateemail.com (Postfix) with ESMTP id E7DDF80051
	for <bitbake-devel@lists.openembedded.org>; Mon,  5 Oct 2020 10:22:10 -0400 (EDT)
Received: from [10.105.0.186] (unknown [10.20.151.236])
	by mta-11.privateemail.com (Postfix) with ESMTPA id 7543680050
	for <bitbake-devel@lists.openembedded.org>; Mon,  5 Oct 2020 14:22:10 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
From: "Charlie Davies" <charles.davies@whitetree.xyz>
Subject: Dunfell Patch Merging?
Message-ID: <f2871b0f-a30e-aaa5-ddfa-3cdf5d67a6e1@whitetree.xyz>
Date: Mon, 5 Oct 2020 15:21:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Content-Type: multipart/alternative;
 boundary="------------C1ED735336BE9E5CCE9DC436"
Content-Language: en-US

--------------C1ED735336BE9E5CCE9DC436
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit


        Hi,

A while ago I implemented the following patch set:


        bitbake: fetch/git: add support for SRC_URI containing spaces in url


        bitbake: tests/fetch: add unit tests for SRC_URI with spaces in url

The patch set was accepted into master branch:

9ef2bc360d9cfc017a510f4d6ce811e6895672b4

005f2951e2118c79d99665ce66d5bc9220f4a0b1

In my day to day work I use dunfell so was hoping that this patch set 
would be included in the dunfell branch. Will this happen?

Out of interest what is the general merging strategy and release cycle?

Many Thanks,

Charlie




--------------C1ED735336BE9E5CCE9DC436
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <h4 style="box-sizing: border-box; font-family: &quot;Helvetica
      Neue&quot;, Helvetica, Arial, sans-serif; font-weight: 500;
      line-height: 1.1; color: rgb(51, 51, 51); margin-top: 10px;
      margin-bottom: 10px; font-size: 18px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      letter-spacing: normal; orphans: 2; text-align: start;
      text-indent: 0px; text-transform: none; white-space: normal;
      widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px;
      background-color: rgb(255, 255, 255); text-decoration-style:
      initial; text-decoration-color: initial;">Hi,</h4>
    <p>A while ago I implemented the following patch set:<br>
    </p>
    <h4 style="box-sizing: border-box; font-family: &quot;Helvetica
      Neue&quot;, Helvetica, Arial, sans-serif; font-weight: 500;
      line-height: 1.1; color: rgb(51, 51, 51); margin-top: 10px;
      margin-bottom: 10px; font-size: 18px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      letter-spacing: normal; orphans: 2; text-align: start;
      text-indent: 0px; text-transform: none; white-space: normal;
      widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px;
      background-color: rgb(255, 255, 255); text-decoration-style:
      initial; text-decoration-color: initial;">bitbake: fetch/git: add
      support for SRC_URI containing spaces in url</h4>
    <h4 style="box-sizing: border-box; font-family: &quot;Helvetica
      Neue&quot;, Helvetica, Arial, sans-serif; font-weight: 500;
      line-height: 1.1; color: rgb(51, 51, 51); margin-top: 10px;
      margin-bottom: 10px; font-size: 18px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      letter-spacing: normal; orphans: 2; text-align: start;
      text-indent: 0px; text-transform: none; white-space: normal;
      widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px;
      background-color: rgb(255, 255, 255); text-decoration-style:
      initial; text-decoration-color: initial;">bitbake: tests/fetch:
      add unit tests for SRC_URI with spaces in url</h4>
    <p>The patch set was accepted into master branch:</p>
    <p>9ef2bc360d9cfc017a510f4d6ce811e6895672b4</p>
    <p>005f2951e2118c79d99665ce66d5bc9220f4a0b1</p>
    <p>In my day to day work I use dunfell so was hoping that this patch
      set would be included in the dunfell branch. Will this happen?</p>
    <p>Out of interest what is the general merging strategy and release
      cycle?</p>
    <p>Many Thanks,</p>
    <p>Charlie<br>
    </p>
    <p><br>
    </p>
    <p><br>
    </p>
  </body>
</html>

--------------C1ED735336BE9E5CCE9DC436--
