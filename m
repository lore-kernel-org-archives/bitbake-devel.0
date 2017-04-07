Return-Path: <patrick.ohly@intel.com>
Received: from mail-it0-f53.google.com (mail-it0-f53.google.com
	[209.85.214.53])
	by mail.openembedded.org (Postfix) with ESMTP id 941EC77D7F
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Apr 2017 07:56:21 +0000 (UTC)
Received: by mail-it0-f53.google.com with SMTP id y18so115035614itc.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 07 Apr 2017 00:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:organization:mime-version:content-transfer-encoding;
	bh=0itxyiPeLHyi+bKTu6+z8uPXXnn2TfGpBLdTeIt+jzM=;
	b=I0+ZkR6oug6F9ZjKGxLYDw3aKy91BzDtUQrZ8MUZGBlEgKRKv7z7kzi7/+06+l7WHa
	UJZpkuUwpMnisgaASZZ6CkfloLUlXM2Y0wFI4WZFq0JFIun0jwd9ezm+YRZZOejFctIa
	dIpMnagbAmiS5BR6fBf+yDNJxG+BZTc1MuOexeg1zpYBn9LtBDQtIcZhwiFpujWOzUX7
	/pPhy7MLRipNnVLxyXG0tDyLMEl3EX8gFtZOwOzYTHT3dtq2Af+QTEfz3vY3CrsM5GA6
	M1X77bCdhMtaBdPEw8v+Kldn/PUmxpWURN5k21WvvbwbUgLEGgbqd3aelFM+37drEr82
	bVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:organization:mime-version:content-transfer-encoding;
	bh=0itxyiPeLHyi+bKTu6+z8uPXXnn2TfGpBLdTeIt+jzM=;
	b=t6JRU671gqR/PD+hmd42XD53cl5lhlRmqoaUEGxzuXqsqzV1zv0XzwH3qttsi+BPVN
	tgtOLnVxNoHcDtoxm1oQIfdQGNSvGnUu5n5GWZTTnSd4DM+/hWpScOZK27+Uvk3QqIGe
	zhsGO5TkvbjikZRhsoR7M1yQDNR94FzP/LNeVTDq2JenpMiHTSqT2uNCJ84Q+375zbqV
	SAxsMiJRuCvfH0KoA1l8ifIXIOjQQPbZOqRT7B20aX3C8LQ7R3jKN4SGGw7/3QxleOD1
	cRRZk1lck13mIot8/5P3mww+qxfNvVE9MsOkYuJ2UUvhALViAf4ASHme/RX0IgLPzH9Z
	G36g==
X-Gm-Message-State: AFeK/H3u24XTbheV7G4O5MW0Zh25W/oANfP1FclRTPtiGsg8X9mOclmDlRim8WtvdiStkI8X
X-Received: by 10.36.71.203 with SMTP id t194mr12367060itb.43.1491551782731;
	Fri, 07 Apr 2017 00:56:22 -0700 (PDT)
Received: from pohly-mobl1 (p5DE8EAD9.dip0.t-ipconnect.de. [93.232.234.217])
	by smtp.gmail.com with ESMTPSA id
	c100sm2125232itd.20.2017.04.07.00.56.20
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 07 Apr 2017 00:56:21 -0700 (PDT)
Message-ID: <1491551779.10884.69.camel@intel.com>
From: Patrick Ohly <patrick.ohly@intel.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Fri, 07 Apr 2017 09:56:19 +0200
In-Reply-To: <cover.1491514854.git.paul.eggleton@linux.intel.com>
References: <cover.1491514854.git.paul.eggleton@linux.intel.com>
Organization: Intel GmbH, Dornacher Strasse 1, D-85622 Feldkirchen/Munich
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 00/11] bitbake-diffsigs fixes/improvements
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
X-List-Received-Date: Fri, 07 Apr 2017 07:56:23 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2017-04-07 at 09:52 +1200, Paul Eggleton wrote:
> As part of an effort to add task signature recording and comparison to
> buildhistory in OE, I went digging into bitbake-diffsigs and the code
> that supports it and discovered that unfortunately it had a number of
> bugs - in particular the -t option despite being around for a while and
> having numerous band-aids applied in the past still wasn't really
> working properly.

I'm not sure whether it is working now, even with your changes. My
test, using poky master and your bitbake branch:

1. bitbake -c cleansstate m4
2. bitbake m4
3. patch m4:
diff --git a/meta/recipes-devtools/m4/m4_1.4.18.bb
b/meta/recipes-devtools/m4/m4_1.4.18.bb
index b12c0adf3ad..0a8e9c10778 100644
--- a/meta/recipes-devtools/m4/m4_1.4.18.bb
+++ b/meta/recipes-devtools/m4/m4_1.4.18.bb
@@ -1,3 +1,7 @@
 require m4-${PV}.inc
 
+do_install_append () {
+    echo hello world
+}
+
 BBCLASSEXTEND = "nativesdk"
4. bitbake m4
5. bitbake-diffsigs -t m4 do_build
=> ERROR: No sigdata files found matching m4 do_build

There is one file for do_build in tmp/stamps/i586-poky-linux/m4 and
several for do_install:

$ ls -l tmp/stamps/i586-poky-linux/m4/*do_build* tmp/stamps/i586-poky-linux/m4/*do_install*
-rw-r--r-- 1 pohly pohly     0 Apr  7 09:53 tmp/stamps/i586-poky-linux/m4/1.4.18-r0.do_build.aa7d33bbb2dfef67ef3ca1b5d3f2cde1
-rw-r--r-- 1 pohly pohly     0 Apr  7 09:53 tmp/stamps/i586-poky-linux/m4/1.4.18-r0.do_install.a0954ae23d8da50c4af22f719255411f
-rw-r--r-- 1 pohly pohly 20573 Apr  7 09:52 tmp/stamps/i586-poky-linux/m4/1.4.18-r0.do_install.sigdata.464e707d80ec982fb5b0c50a6526f05a
-rw-r--r-- 1 pohly pohly 19610 Apr  7 09:53 tmp/stamps/i586-poky-linux/m4/1.4.18-r0.do_install.sigdata.a0954ae23d8da50c4af22f719255411f


bitbake-diffsigs does not fail for do_install, but does not print
anything either (= no output at all from "bitbake-diffsigs -t m4
do_install").

Hmm, does it pick the right files to compare?

$ bitbake-diffsigs -d -t m4 do_install
DEBUG: Signature file (previous): /fast/build/poky/x86/sstate-cache/a0/sstate:m4:i586-poky-linux:1.4.18:r0:i586:3:a0954ae23d8da50c4af22f719255411f_install.tgz.siginfo
DEBUG: Signature file (latest): /fast/build/poky/x86/tmp/stamps/i586-poky-linux/m4/1.4.18-r0.do_install.sigdata.a0954ae23d8da50c4af22f719255411f

Am I using the tool incorrectly or are my expectations wrong?

My expectation was that "bitbake-diffsigs -t m4 do_build" would tell me
that m4 was rebuilt because some tasks that it depends on changed, and
then I would drill down to those tasks, eventually arriving at
do_install.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.




