Return-Path: <benixvincent@yahoo.com>
Received: from nm41.bullet.mail.bf1.yahoo.com (nm41.bullet.mail.bf1.yahoo.com
	[216.109.114.57])
	by mail.openembedded.org (Postfix) with ESMTP id E895A60886
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  6 Aug 2013 04:51:54 +0000 (UTC)
Received: from [98.139.212.153] by nm41.bullet.mail.bf1.yahoo.com with NNFMP;
	06 Aug 2013 04:51:55 -0000
Received: from [98.139.212.244] by tm10.bullet.mail.bf1.yahoo.com with NNFMP;
	06 Aug 2013 04:51:55 -0000
Received: from [127.0.0.1] by omp1053.mail.bf1.yahoo.com with NNFMP;
	06 Aug 2013 04:51:55 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 370004.62304.bm@omp1053.mail.bf1.yahoo.com
Received: (qmail 14645 invoked by uid 60001); 6 Aug 2013 04:51:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024;
	t=1375764715; bh=lNgYXhQreg6YeQn341sUpSMIi7voS/pTfC5ulOxU9xk=;
	h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type;
	b=SAGluhqr9C20Bn5SkyQI1QpCvrNXoZYKncFIYFbGzPKfvt8rZbAVMWgwE8ZrUj5NoisXxXh4RarET+EDHRcJhzxC2krK7/4L02yMw338/POmbSH9irfLfAAxe8M3W0dUB7azS1T5DhgTN+s3ZeRI5ByG/ykBEusmNBKqw/qJrRU=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=s1024; d=yahoo.com;
	h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type;
	b=S0gcCSicFHG3xiTrfIWqkb6SrEXBi+ggXx26Az1VP4vNEL/BN+/B8GI8d5T5Q7TeYA3TkVzaFqrQ8BfcxZkT1RundeD1G7F1XsipHH9ihkPU8XjRoLyoF8rGEMuGN6px+YySxMyHDLu1jniYbN+VCz06wZFxiDnUpAU49shhnYo=;
X-YMail-OSG: BfNP05gVM1n.lETJ4dJZbj1C4mOVrL8MWKoQygIP5Zzk.kM
	tE8PLZbQPKZ2W1zcWuVDs1fhZYZ1qdXRO19lUT9TLQapx7tI.QJKvigyQWAs
	nu53mN2oYGMDRv6gu2MIIlHhr.7SM2.LQyRbd03ZIFNFJvWHT6tIwtj3djFa
	Toy773eT9.2YbUhOSIxre6LWdvqBnQHGxKYAbp72pbVpU8c50j2DItiK2Kz6
	VoEM5_9qlVi23t4nJ1lO_ss_7vh2INItUjSGIhFinuu723f7EYvRQz0qZQIH
	h_xoapAQp5R7BOnTNBe99slpS8XqefmNHs0vbWQhVIrSXxxWMQyhANGtxo1w
	iCwmjmm91T23guqUpIA.ijvi719gjEQBuWTNDegRIlW_YqxExoty2G_0udHQ
	Nl.NuoouPB1Y2nH8UIgZB4dIDqeW1f0TA0206PLE7M1b83qpYMfJaUyUD6N0
	ZfY49PoY_SMDBmsrgY6uuhoQfs5JWX9sayhu3botAIfq3Mle3uV9c5KWlwKv
	abtNlOYH0PcE3xsFVFnCOBziNGMtBDUrGTo21RBxFUgM5R9iZCpXKf35Pe66
	a00zuh6O3o2ILsEI06J_c6utJC6bZ8N1ZEHmV_yUNoDGRbnbi.xlL3tomwC_
	TYLsA6VPNpFU8K9j_7qypJi8Mz540IEg-
Received: from [72.163.217.102] by web162605.mail.bf1.yahoo.com via HTTP;
	Mon, 05 Aug 2013 21:51:55 PDT
X-Rocket-MIMEInfo: 002.001,
	CgoKSGkKCkkgbmVlZCB0byBsYXVuY2ggbXVsdGlwbGUgaW5pdHNjcmlwdHMgKDIpIGZvciBhIHNpbmdsZSBwYWNrYWdlLCBJIHRyaWVkIHRoZSBmb2xsb3dpbmc7CgoKSU5JVFNDUklQVF9OQU1FID0gImRpYWcuc2giCklOSVRTQ1JJUFRfUEFSQU1TID0gImRlZmF1bHRzIDE2IgoKCklOSVRTQ1JJUFRfTkFNRSA9ICJkcml2ZXJzLWluaXQuc2ggIgpJTklUU0NSSVBUX1BBUkFNUyA9ICJkZWZhdWx0cyAxNCIKCgpCdXQgdGhlIHNlY29uZCBvbmUgb3ZlcndyaXRlcyB0aGUgZmlyc3QgYW5kIEkgc2VlIGp1c3Qgb24BMAEBAQE-
X-Mailer: YahooMailWebService/0.8.152.567
Message-ID: <1375764715.11349.YahooMailNeo@web162605.mail.bf1.yahoo.com>
Date: Mon, 5 Aug 2013 21:51:55 -0700 (PDT)
From: Benix Vincent <benixvincent@yahoo.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
MIME-Version: 1.0
Subject: Multiple init script in bitbake file
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
Reply-To: Benix Vincent <benixvincent@yahoo.com>
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 06 Aug 2013 04:51:55 -0000
Content-Type: multipart/alternative;
	boundary="1157309285-2035693844-1375764715=:11349"

--1157309285-2035693844-1375764715=:11349
Content-Type: text/plain; charset=us-ascii




Hi

I need to launch multiple initscripts (2) for a single package, I tried the following;


INITSCRIPT_NAME = "diag.sh"
INITSCRIPT_PARAMS = "defaults 16"


INITSCRIPT_NAME = "drivers-init.sh "
INITSCRIPT_PARAMS = "defaults 14"


But the second one overwrites the first and I see just one init script in my sandbox.

then I even tried this



INITSCRIPT_NAME_diag1 = "diag.sh"
INITSCRIPT_PARAMS_diag1 = "defaults 16"


INITSCRIPT_NAME_diag2 = "drivers-init.sh "
INITSCRIPT_PARAMS_diag2 = "defaults 14"



even this didn't work.

Any help is greatly appreciated.

Benix.

--1157309285-2035693844-1375764715=:11349
Content-Type: text/html; charset=us-ascii

<html><body><div style="color:#000; background-color:#fff; font-family:times new roman, new york, times, serif;font-size:12pt"><div style="font-family: 'times new roman', 'new york', times, serif; font-size: 12pt;"><br></div><div style="font-family: 'times new roman', 'new york', times, serif; font-size: 16px; color: rgb(0, 0, 0); background-color: transparent; font-style: normal;"><br></div><div style="font-family: 'times new roman', 'new york', times, serif; font-size: 16px; color: rgb(0, 0, 0); background-color: transparent; font-style: normal;">Hi</div><div style="font-family: 'times new roman', 'new york', times, serif; font-size: 16px; color: rgb(0, 0, 0); background-color: transparent; font-style: normal;"><br></div><div style="font-family: 'times new roman', 'new york', times, serif; font-size: 16px; color: rgb(0, 0, 0); background-color: transparent; font-style: normal;">I need to launch multiple initscripts (2) for a single package, I tried the
 following;</div><div style="font-family: 'times new roman', 'new york', times, serif; font-size: 16px; color: rgb(0, 0, 0); background-color: transparent; font-style: normal;"><br></div><div style="background-color: transparent;"><font face="times new roman, new york, times, serif"><br></font></div><div style="background-color: transparent;"><font face="times new roman, new york, times, serif">INITSCRIPT_NAME = "diag.sh"</font></div><div style="background-color: transparent; color: rgb(0, 0, 0); font-size: 16px; font-family: 'times new roman', 'new york', times, serif; font-style: normal;"><font face="times new roman, new york, times, serif"><span style="font-size: 16px;">INITSCRIPT_PARAMS = "defaults 16"</span><br></font></div><div style="background-color: transparent; color: rgb(0, 0, 0); font-size: 16px; font-family: 'times new roman', 'new york', times, serif; font-style: normal;"><font face="times new roman, new york, times, serif"><span
 style="font-size: 16px;"><br></span></font></div><div style="background-color: transparent;"><font face="times new roman, new york, times, serif">INITSCRIPT_NAME = "drivers-init.sh "</font></div><div style="background-color: transparent; color: rgb(0, 0, 0); font-size: 16px; font-family: 'times new roman', 'new york', times, serif; font-style: normal;"><span style="background-color: transparent;">INITSCRIPT_PARAMS = "defaults 14"</span><br></div><div style="background-color: transparent; color: rgb(0, 0, 0); font-size: 16px; font-family: 'times new roman', 'new york', times, serif; font-style: normal;"><font face="times new roman, new york, times, serif"><br></font></div><div style="background-color: transparent; color: rgb(0, 0, 0); font-size: 16px; font-family: 'times new roman', 'new york', times, serif; font-style: normal;">But the second one overwrites the first and I see just one init script in my sandbox.</div><div style="background-color:
 transparent; color: rgb(0, 0, 0); font-size: 16px; font-family: 'times new roman', 'new york', times, serif; font-style: normal;"><br></div><div style="background-color: transparent; color: rgb(0, 0, 0); font-size: 16px; font-family: 'times new roman', 'new york', times, serif; font-style: normal;"><span style="font-size: 16px;">then I even tried this</span><br></div><div style="background-color: transparent; color: rgb(0, 0, 0); font-size: 16px; font-family: 'times new roman', 'new york', times, serif; font-style: normal;"><span style="font-size: 16px;"><br></span></div><div style="background-color: transparent;"><font face="times new roman, new york, times, serif"><br></font></div><div style="background-color: transparent;"><font face="times new roman, new york, times, serif">INITSCRIPT_NAME_diag1 = "diag.sh"</font></div><div style="background-color: transparent; color: rgb(0, 0, 0); font-size: 16px; font-family: 'times new roman', 'new york', times,
 serif; font-style: normal;"><font face="times new roman, new york, times, serif"><span style="font-size: 16px;">INITSCRIPT_PARAMS_diag1 = "defaults 16"</span><br></font></div><div style="background-color: transparent; color: rgb(0, 0, 0); font-size: 16px; font-family: 'times new roman', 'new york', times, serif; font-style: normal;"><font face="times new roman, new york, times, serif"><span style="font-size: 16px;"><br></span></font></div><div style="background-color: transparent;"><font face="times new roman, new york, times, serif">INITSCRIPT_NAME_diag2 = "drivers-init.sh "</font></div><div style="background-color: transparent;"><span style="font-family: 'times new roman', 'new york', times, serif; background-color: transparent;">INITSCRIPT_PARAMS_diag2 = "defaults 14"</span><br></div><div style="background-color: transparent; color: rgb(0, 0, 0); font-size: 16px; font-family: 'Times New Roman'; font-style: normal;"><span style="font-family: 'times
 new roman', 'new york', times, serif; background-color: transparent;"><br></span></div><div style="background-color: transparent; color: rgb(0, 0, 0); font-size: 16px; font-family: 'times new roman', 'new york', times, serif; font-style: normal;"><span style="font-family: 'times new roman', 'new york', times, serif; background-color: transparent;"><br></span></div><div style="background-color: transparent; color: rgb(0, 0, 0); font-size: 16px; font-family: 'times new roman', 'new york', times, serif; font-style: normal;"><span style="font-family: 'times new roman', 'new york', times, serif; background-color: transparent;">even this didn't work.</span></div><div style="background-color: transparent; color: rgb(0, 0, 0); font-size: 16px; font-family: 'times new roman', 'new york', times, serif; font-style: normal;"><span style="font-family: 'times new roman', 'new york', times, serif; background-color: transparent;"><br></span></div><div
 style="background-color: transparent; color: rgb(0, 0, 0); font-size: 16px; font-family: 'times new roman', 'new york', times, serif; font-style: normal;"><span style="font-family: 'times new roman', 'new york', times, serif; background-color: transparent;">Any help is greatly appreciated.</span></div><div style="background-color: transparent; color: rgb(0, 0, 0); font-size: 16px; font-family: 'times new roman', 'new york', times, serif; font-style: normal;"><span style="font-family: 'times new roman', 'new york', times, serif; background-color: transparent;"><br></span></div><div style="background-color: transparent; color: rgb(0, 0, 0); font-size: 16px; font-family: 'times new roman', 'new york', times, serif; font-style: normal;"><span style="font-family: 'times new roman', 'new york', times, serif; background-color: transparent;">Benix.</span></div></div></body></html>

--1157309285-2035693844-1375764715=:11349--
