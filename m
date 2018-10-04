Return-Path: <stefan@agner.ch>
Received: from mail.kmu-office.ch (mail.kmu-office.ch [178.209.48.109])
	by mail.openembedded.org (Postfix) with ESMTP id C92AD745C3
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Oct 2018 16:08:10 +0000 (UTC)
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
	by mail.kmu-office.ch (Postfix) with ESMTPSA id 0D6615C1535;
	Thu,  4 Oct 2018 18:08:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
	t=1538669291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:in-reply-to:
	references; bh=8ajHYypWX2jQyc9xBrq4mBswik38DDHMjl7fy37wZV8=;
	b=C5J8ScRE3v+k81HwHu3pn7zaevjoda0o7zdhua94E2hs2KQUdzKxXH2l69UpwRFrmIVewC
	f5UdL3GvbPM1qbWsyiASbPjbLrk5Et5q3WZ9ryfbnCvkjkwIwj/cvLSPmM7psuVLt6oH1O
	YBqrQmL61dMcEFuUvqTdPoC+TxAzLQI=
MIME-Version: 1.0
Date: Thu, 04 Oct 2018 18:08:11 +0200
From: Stefan Agner <stefan@agner.ch>
To: mark.hatle@windriver.com, ricardo@foundries.io
Message-ID: <bfa936254124b13689c89dcee2a4e427@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Cc: bitbake-devel@lists.openembedded.org
Subject: git submodule fetcher regression
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
X-List-Received-Date: Thu, 04 Oct 2018 16:08:11 -0000
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

[resend, this time with me being subscriber of bitbake-devel]

Hi,

It seems that 9c6b39adf978 ("fetch2/gitsm.py: Rework the git submodule fetcher") broke git submodules in some cases. My particular case is aktualizr from meta-updater (https://github.com/advancedtelematic/meta-updater). Fetching aktualizr reliably fails for me now:

ERROR: aktualizr-1.0+gitAUTOINC+a94a15e31f-7 do_unpack: Fetcher failure: Submodule tests/tuf-test-vectors does not exist in /home/ags/oe/downloads/git2/github.com.advancedtelematic.aktualizr/modules/tests/tuf-test-vectors or
/home/ags/oe/build-colibri-imx7/tmp-oe/work/armv7at2hf-neon-lmp-linux-gnueabi/aktualizr/1.0+gitAUTOINC+a94a15e31f-7/git/.git/modules/tests/tuf-test-vectors.                         
ERROR: aktualizr-1.0+gitAUTOINC+a94a15e31f-7 do_unpack: Function failed: base_do_unpack
ERROR: Logfile of failure stored in: /home/ags/oe/build-colibri-imx7/tmp-oe/work/armv7at2hf-neon-lmp-linux-gnueabi/aktualizr/1.0+gitAUTOINC+a94a15e31f-7/temp/log.do_unpack.35143
ERROR: Task (/home/ags/oe/build-colibri-imx7/conf/../../layers/meta-updater/recipes-sota/aktualizr/aktualizr_git.bb:do_unpack) failed with exit code '1'

Any idea what that could be?

--
Stefan

