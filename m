Return-Path: <Liam.Howlett@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id E0E4C73D17
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Apr 2015 17:06:13 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.9/8.14.9) with ESMTP id t3GH6D31009814
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Apr 2015 10:06:14 -0700 (PDT)
Received: from yow-lhowlett-d0.wrs.com (128.224.56.215) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.3.224.2; Thu, 16 Apr 2015 10:06:22 -0700
From: "Liam R. Howlett" <Liam.Howlett@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 16 Apr 2015 13:06:12 -0400
Message-ID: <1429203973-26562-1-git-send-email-Liam.Howlett@WindRiver.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1429121824-31200-2-git-send-email-Liam.Howlett@WindRiver.com>
References: <1429121824-31200-2-git-send-email-Liam.Howlett@WindRiver.com>
MIME-Version: 1.0
Subject: [PATCH v3] fetch2: Add BB_ALLOWED_NETWORKS support
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
X-List-Received-Date: Thu, 16 Apr 2015 17:06:19 -0000
Content-Type: text/plain

This patch adds support for a new local.conf variable called
BB_ALLOWED_NETWORKS.  BB_ALLOWED_NETWORKS holds a list of hostnames that the
user trusts as a source for downloading content.  If network access is enabled
and the user has configured trusted hosts, then any hosts that are not in the
list will cause an error to occur at fetch.  Any mirrors and pre-mirrors that
are not in the list will result in warnings that these locations will not be
used.

The BB_NO_NETWORK variable still stops all network access.

Please see the comments in the patch for more details and example usage.

Liam R. Howlett (1):
  fetch2: Add BB_ALLOWED_NETWORKS support

 lib/bb/fetch2/__init__.py | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/bb/tests/fetch.py     | 37 +++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

-- 
2.1.1


