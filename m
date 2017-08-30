Return-Path: <o.mandel@menlosystems.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by mail.openembedded.org (Postfix) with ESMTP id BC5027832A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Aug 2017 12:40:04 +0000 (UTC)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3xj4pY0dP4z1qrN9
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Aug 2017 14:40:04 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
	by mail.m-online.net (Postfix) with ESMTP id 3xj4pX6Plxz3hjJp
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Aug 2017 14:40:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
	port 10024)
	with ESMTP id AczZdekgU370 for <bitbake-devel@lists.openembedded.org>; 
	Wed, 30 Aug 2017 14:40:04 +0200 (CEST)
X-Auth-Info: VeW6JuBoWeNWf+d3tNIWhIkmH6BlZoKucEbkrxAGC1sn1yL9sKdIBYmf3VnOPw51
Received: from [10.0.0.72] (host-141-40-253-38.customer.izb-online.de
	[141.40.253.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Aug 2017 14:40:04 +0200 (CEST)
To: bitbake-devel@lists.openembedded.org
From: Olaf Mandel <o.mandel@menlosystems.com>
Message-ID: <adcc19b8-8834-cfe9-cb26-9a463ce42f43@menlosystems.com>
Date: Wed, 30 Aug 2017 14:38:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
	Thunderbird/52.3.0
MIME-Version: 1.0
Subject: Question on toaster bringup
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
X-List-Received-Date: Wed, 30 Aug 2017 12:40:05 -0000
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hello,

I want to initialize toaster from fixtures alone, if possible. It should
only provide a "local" release (no network dependency at all). Here I
ran into two to three problems:

* the oe-core.xml fixture adds three releases. Is it possible to
remove/delete objects in the custom.xml fixture that I do not want?
Currently I am working around that by just configuring out the line
call_command("loaddata", "oe-core") in checksettings.py.

* the custom.xml fixture needs to reside in the
bitbake/lib/toaster/orm/fixtures directory to be found. How can I search
at other places? Setting an environment variable FIXTURE_DIRS didn't
seem to help.

* minor point: would it make sense to detect if
call_command("lsupdates") is needed? One does not need that for a purely
local release and I have it commented out.

Thank you for your time,
Olaf
- -- 
Olaf Mandel

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJZprHhAAoJEFS9nbRiUh3/YeEIAIWvZIb0gECYO+mTrcZu+7w7
Zmtg2ZcYM2BWwthzJl4aA48vVjwYOpY74oQnByorEJh6yjSob/GqAFgPKbNGVF+a
zH1BCkzao7oAdYtY5naYfYyaD5iDvStl/pfxCoxujh7wC9k7o11gBXO2HIp4U/Ww
8kiNlDpjI2dOciuanYB9hluOtwJ+pBJsuFhktTRKn3f7hSkPq1Q/C+L8dJEBc9sl
JyQ5yNdEhXhrvCPT1wyJtxnHiAXIK/nQrXb0uEFzLv1ENxgCiGVxY6GsHm7KSXf/
I53I+m5kWiBozgo5bXPfj6W0se/v7EsU30kOCilUCAf6bl65LS2EyqVndTJCHZ4=
=GW/i
-----END PGP SIGNATURE-----

