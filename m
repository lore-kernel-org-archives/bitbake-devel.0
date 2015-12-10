Return-Path: <contact@stefanchrist.eu>
X-Greylist: delayed 1225 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 10 Dec 2015 21:18:05 UTC
Received: from stcim.de (stcim.de [78.46.73.102])
	by mail.openembedded.org (Postfix) with ESMTP id EBB456012C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Dec 2015 21:18:05 +0000 (UTC)
Received: from [2a01:4f8:120:4065:2::2] (helo=sill.h.stcim.de)
	by stcim.de with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
	(Exim 4.84) (envelope-from <contact@stefanchrist.eu>)
	id 1a78HU-0005jC-TW for bitbake-devel@lists.openembedded.org;
	Thu, 10 Dec 2015 21:57:41 +0100
Date: Thu, 10 Dec 2015 21:57:39 +0100
From: Christ Stefan <contact@stefanchrist.eu>
To: bitbake-devel@lists.openembedded.org
Message-ID: <20151210205739.GB622@sill.h.stcim.de>
MIME-Version: 1.0
X-PGP-Key: http://stefanchrist.eu/personal/Stefan%20Christ.asc
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailman-Approved-At: Mon, 14 Dec 2015 23:08:38 +0000
Subject: Missing tags in the bitbake repository
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
X-List-Received-Date: Thu, 10 Dec 2015 21:18:06 -0000
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

I cannot find tags for all bitbake versions (__version__ in file
bin/bitbake) in the repository

    git://git.openembedded.org/bitbake

For example tags for

    1.17.1 1.25.0 and 1.27.1 

are missing and much more are missing, too. Is there a reason for that?

Kind regards,
Stefan Christ

-- 
pgp-key id:  0x117C3CFA
fingerprint: 1245 44A4 9DCB 4A70 1E21  8A46 7B9E 49D4 117C 3CFA
download:    https://www.stefanchrist.eu/personal/Stefan%20Christ.asc

https certificate for www.stefanchrist.eu (until Dec 10 18:04:58 2016 GMT):
SHA256 Fingerprint=2D:B9:70:7B:F6:B4:24:5D:C2:5D:96:70:4B:33:93:C6:1C:0B:81:B5:
                   15:6F:98:15:33:67:9A:89:A6:26:3B:5C
SHA1 Fingerprint  =A1:27:51:21:49:6C:C9:C7:EE:B7:BA:F0:B2:B7:9C:D6:66:22:20:5F
MD5 Fingerprint   =C9:FE:A4:7D:9D:0D:6B:B6:09:BE:88:2C:F3:C3:A7:07

