Return-Path: <zboszor@pr.hu>
X-Greylist: delayed 729 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 02 Feb 2018 17:20:27 UTC
Received: from mail7.pr.hu (mail7.pr.hu [87.242.0.7])
	by mail.openembedded.org (Postfix) with ESMTP id 3CD58782F6
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Feb 2018 17:20:27 +0000 (UTC)
Received: from [2a02:808:3:101::5] (helo=mail.pr.hu)
	by frontdoor.pr.hu with esmtps
	(TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
	(envelope-from <zboszor@pr.hu>) id 1ehep3-0003Rw-8E
	for bitbake-devel@lists.openembedded.org;
	Fri, 02 Feb 2018 18:08:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pr.hu;
	s=pr20170203;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=jmDWbCzy3Hs/bZ1h0+NVY4wv+96FYJFYI4HETcddxpI=;
	b=WqeskkgHzRtNB9iRnpAZ2RfHF8
	+TWE6lWGL4N7ZYttwwzlGlk1RKwIdj/nCXu23uF5GmXi2jYXzQQag1nG8BsX3wnOanSrAVz5VDjVU
	EP1orvLLdS2Mls0m2Swf6xXGaKxmzOJIsmhP7EAYgNxWs8ocNUcaMg09znXQlg64+s2lNJuOQxUQl
	90LYlQIPSSXEMayLNIeFsv+JMRoOCPSWzLPasQ5lZ1Nu6XK0WMEaZtsBgeKx2WkzHzaHbwQ4kr14w
	/15GTGnuWJO5WrvcgSliCrmH3CqnC6+OyvT4d3YKqqrYJoFFXfC61ULteQlSL9kJ3K23QlOfUwhzR
	tm5zZv+w==;
Received: from host-87-242-32-111.prtelecom.hu ([87.242.32.111]
	helo=s002.sicom.com)
	by mail.pr.hu with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.89) (envelope-from <zboszor@pr.hu>) id 1eheow-0007bv-Iq
	for bitbake-devel@lists.openembedded.org;
	Fri, 02 Feb 2018 18:08:16 +0100
To: bitbake-devel@lists.openembedded.org
From: =?UTF-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszor@pr.hu>
Message-ID: <6c003a37-1455-4a3c-4b67-9a212cda5292@pr.hu>
Date: Fri, 2 Feb 2018 18:08:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.5.2
MIME-Version: 1.0
X-Spam-Score: 0.5 (/)
X-Scan-Signature: 9c5e05eb7b369c1b31c27083e129340a
X-Spam-Tracer: backend.mail.pr.hu 0.5 20180202170816Z
Subject: Bitbake npm fetcher goes into infinite loop
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
X-List-Received-Date: Fri, 02 Feb 2018 17:20:28 -0000
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

Hi,

I have found a node module (cli-color) whose dependencies
seem to contain a circular dependency among themselves
and the do_fetch phase goes into an infinite loop:

...
DEBUG: Calling getdeps on d
DEBUG: Running export PATH="..."; export HOME="/home/zboszormenyi"; npm view d@'1' --json 
--registry http://registry.npmjs.org/
DEBUG: Calling getdeps on es5-ext
DEBUG: Running export PATH="..."; export HOME="/home/zboszormenyi"; npm view 
es5-ext@'^0.10.9' --json --registry http://registry.npmjs.org/
DEBUG: Calling getdeps on es6-symbol
DEBUG: Running export PATH="..."; export HOME="/home/zboszormenyi"; npm view 
es6-symbol@'~3.1.1' --json --registry http://registry.npmjs.org/
DEBUG: Calling getdeps on d
...

I am using Yocto 2.4 that reports using Bitbake 1.36:
BB_VERSION           = "1.36.0"

I am happy to test patches that fix this.

Thanks in advance,
Zoltán Böszörményi

