Return-Path: <Liam.Howlett@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id CE7BA73C63
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 31 Mar 2015 18:39:49 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.9/8.14.9) with ESMTP id t2VIdoYo015294
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 31 Mar 2015 11:39:51 -0700 (PDT)
Received: from yow-lhowlett-d0.wrs.com (128.224.56.215) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.3.224.2; Tue, 31 Mar 2015 11:39:50 -0700
From: "Liam R. Howlett" <Liam.Howlett@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 31 Mar 2015 14:39:49 -0400
Message-ID: <1427827190-10442-1-git-send-email-Liam.Howlett@WindRiver.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Subject: [PATCH] fetch2: Add BB_TRUSTED_NETWORK support
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
X-List-Received-Date: Tue, 31 Mar 2015 18:39:50 -0000
Content-Type: text/plain

This patch adds support for a new local.conf variable called
BB_TRUSTED_NETWORK.  BB_TRUSTED_NETWORK holds a list of hostnames that the user
trusts as a source for downloading content.  If network access is enabled and
the user has configured trusted hosts, then any hosts that are not in the list
will cause an error to occur at fetch.  Any mirrors and pre-mirrors that are
not in the list will result in warnings that these locations will not be used.

The BB_NO_NETWORK variable still stops all network access.

Please see the comments in the patch for more details and example usage.

Liam R. Howlett (1):
  fetch2: Add BB_TRUSTED_NETWORK support

 lib/bb/fetch2/__init__.py | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/bb/tests/fetch.py     | 33 +++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

-- 
2.1.0


