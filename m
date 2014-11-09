Return-Path: <akuster808@gmail.com>
Received: from mail-pd0-f170.google.com (mail-pd0-f170.google.com
	[209.85.192.170])
	by mail.openembedded.org (Postfix) with ESMTP id C76CE65CED;
	Sun,  9 Nov 2014 04:43:12 +0000 (UTC)
Received: by mail-pd0-f170.google.com with SMTP id z10so5746136pdj.15
	for <multiple recipients>; Sat, 08 Nov 2014 20:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:subject
	:content-type:content-transfer-encoding;
	bh=zbIyNZy/lSkvjPtLro53MpO1Yj7lR9uYiL8s6iQcdnQ=;
	b=HY5PIj9eo9vPr+WNv7VYPLq+hp6S9q/5RZIS4CBHCaANbJTV4sQrNs6G8QQsHnkgc8
	6wWKlR98tjSYBIoZHEQjbShJX3AvllSvsWnEEXeW0aQ8y4C0QnuwFK7ZpZbkFQrChqe/
	jHDFcublm2MSMetu29QsfDLIbwNDhxKOH9twji2PJCChWT92WRxppN8S1SWQVcxUTz7J
	JPHNt+UfxYsbhR3tcDABkjOa22phGr0RzmiT9VT8lWJXhPN4XzfY5jA8Lq6wFnln22QV
	T/0eLgKZ6qiC3lH1m7vFdvKF8ch2GrzGShsarXf+lxrCebgOjR1yvEXUT6lg3F/Cbeoc
	Hc3g==
X-Received: by 10.66.227.103 with SMTP id rz7mr22676889pac.45.1415508192607;
	Sat, 08 Nov 2014 20:43:12 -0800 (PST)
Received: from ?IPv6:2601:c:9380:601:b578:697e:ba17:25f9?
	([2601:c:9380:601:b578:697e:ba17:25f9])
	by mx.google.com with ESMTPSA id h1sm12919810pat.6.2014.11.08.20.43.10
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 08 Nov 2014 20:43:11 -0800 (PST)
Message-ID: <545EF0DC.6030200@gmail.com>
Date: Sat, 08 Nov 2014 20:43:08 -0800
From: akuster808 <akuster808@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To: OE-core <openembedded-core@lists.openembedded.org>, 
	bitbake-devel@lists.openembedded.org
X-Mailman-Approved-At: Sun, 23 Nov 2014 21:58:57 +0000
Subject: building world
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
X-List-Received-Date: Sun, 09 Nov 2014 04:43:21 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I am seeing a warning while build world on oo-core Master and Dizzy.

"WARNING: Building libpam but 'pam' isn't in DISTRO_FEATURES, PAM won't 
work correctly"

It seems to me that if one is building 'world' then all 
"DISTRO_FEATURES" should be defined, otherwise World isn't really world.


Should we fix 'world' build or mask out packages?

regards,
Armin

