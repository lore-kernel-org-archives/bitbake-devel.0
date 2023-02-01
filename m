Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED103C636D4
	for <webhook@archiver.kernel.org>; Wed,  1 Feb 2023 21:30:56 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web10.37352.1675287055201947072
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Feb 2023 13:30:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=U5reqDMW;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: alexandre.belloni@bootlin.com)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id C46FEFF803;
	Wed,  1 Feb 2023 21:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1675287053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OMdruLaYZI8Vw56/JlD4MiV6cn/8NEK5lLoeO7krEto=;
	b=U5reqDMWI8nssUd24Z7bQW9A2pL5kEKz1WHBAtVpRfk30XOasmXG4zpsLk29wrBM5ZQVh7
	+Wug98h3WyoseQ4PrmzymgKA7J0suhuAZ3aJfl0aVwWe/2ByCvlP+bIG05is9d9PBmz5f0
	vRIc9Zc0FUgLMtpJMq/LF10h5+K5nsWn1xscNwm/dUdyRrxMGYm5qUszM4huqMCqEE1nkU
	w0Mf8sQeSCxLVUPDU8xBWc4Kk0qRiU013Tx9btgZrVw9kwnhbdI9b1ZjX3A7G7MJzpxyRg
	/isnIsKTs5horQ7yGSKHt3/7SnUwkhQWwip5zGy07fcsNUTOc802Hvy2RVA7mQ==
Date: Wed, 1 Feb 2023 22:30:52 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: anders.joergensen@advent.energy
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] Add path control to BB_ALLOWED_NETWORKS
Message-ID: <Y9raDFsNMvuuhBRI@mail.local>
References: <xWAM.1675259966225954323.ROLQ@lists.openembedded.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xWAM.1675259966225954323.ROLQ@lists.openembedded.org>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Feb 2023 21:30:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14368

Hello,

This patch doesn't apply, it is malformed

On 01/02/2023 05:59:26-0800, Anders J�rgensen via lists.openembedded.org wrote:
> From: =?UTF-8?q?Anders=20J=C3=B8rgensen?= <anders.joergensen@advent.energy>
> Date: Wed, 1 Feb 2023 13:08:11 +0100
> Subject: [PATCH] Add path control to BB_ALLOWED_NETWORKS
> 
> Make it able to add path control to the allowed network, so e.g. it is only possible to access own repositories at a given host
> 
> Eg.
> BB_ALLOWED_NETWORKS="bitbucket.org/your_company"
> The fetcher will be able to download from bitbucket.org/your_company but not from bitbucket.org/other_company
> ---
> .../bitbake-user-manual-ref-variables.rst� � �|� 3 +++
> bitbake/lib/bb/fetch2/__init__.py� � � � � � �| 23 +++++++++++++++----
> bitbake/lib/bb/tests/fetch.py� � � � � � � � �| 12 ++++++++++
> 3 files changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index af4ff9805c..7942cd2d3a 100644
> --- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -84,6 +84,9 @@ overview of their function and contents.
> 
> -� Attempts to access networks not in the host list cause a failure.
> 
> +� � � -� Limit path control is also possible like. ::
> +� � � � � � BB_ALLOWED_NETWORKS = "github.com/your_project bitbucket.org/your_company"
> +
> Using :term:`BB_ALLOWED_NETWORKS` in conjunction with

There are missing spaces here

> :term:`PREMIRRORS` is very useful. Adding the
> host you want to use to :term:`PREMIRRORS` results in the source code
> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
> index ac557176d7..69ad898464 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -1158,12 +1158,27 @@ def trusted_network(d, url):
> 
> network = network.split(':')[0]
> network = network.lower()
> +� � path = path.lower()
> +
> +� � for host_path in trusted_hosts.split(" "):
> +� � � � host_path = host_path.lower()
> +� � � � is_trusted = False
> +� � � � split_data = host_path.split("/", 1)
> +� � � � host = split_data[0]
> +� � � � trusted_path = None
> +� � � � if len(split_data) == 2:
> +� � � � � � trusted_path = "/" + split_data[1]
> 
> -� � for host in trusted_hosts.split(" "):
> -� � � � host = host.lower()
> if host.startswith("*.") and ("." + network).endswith(host[1:]):
> -� � � � � � return True
> -� � � � if host == network:
> +� � � � � � is_trusted = True
> +� � � � elif host == network:
> +� � � � � � is_trusted = True
> +
> +� � � � if trusted_path and is_trusted:
> +� � � � � � if not path.startswith(trusted_path):
> +� � � � � � � � is_trusted = False
> +
> +� � � � if is_trusted:
> return True
> 
> return False
> diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
> index 1152e89c0d..c641c1221e 100644
> --- a/bitbake/lib/bb/tests/fetch.py
> +++ b/bitbake/lib/bb/tests/fetch.py
> @@ -1288,6 +1288,18 @@ class TrustedNetworksTest(FetcherTest):
> self.d.setVar("BB_ALLOWED_NETWORKS", "server1.org server2.org server3.org")
> self.assertFalse(bb.fetch.trusted_network(self.d, url))
> 
> +� � def test_trusted_network_path(self):
> +� � � � # Ensure trusted_network returns true when the host and path IS in the list.
> +� � � � url = "git://Someserver.org/RightPath/foo;rev=1;branch=master"
> +� � � � self.d.setVar("BB_ALLOWED_NETWORKS", "server1.org *.someserver.org/rightpath server2.org")
> +� � � � self.assertTrue(bb.fetch.trusted_network(self.d, url))
> +
> +� � def test_untrusted_network_path(self):
> +� � � � # Ensure trusted_network returns False when the host is in list but the path is wrong.
> +� � � � url = "git://Someserver.org/WrongPath/foo;rev=1;branch=master"
> +� � � � self.d.setVar("BB_ALLOWED_NETWORKS", "server1.org *.someserver.org/rightpath server2.org")
> +� � � � self.assertFalse(bb.fetch.trusted_network(self.d, url))
> +
> class URLHandle(unittest.TestCase):
> 
> datatable = {
> --
> 2.34.1

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14363): https://lists.openembedded.org/g/bitbake-devel/message/14363
> Mute This Topic: https://lists.openembedded.org/mt/96676597/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

