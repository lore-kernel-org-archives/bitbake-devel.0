Return-Path: <Liam.Howlett@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id C464A7404C
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 May 2015 15:56:24 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.9/8.14.9) with ESMTP id t4FFuPw8014965
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 May 2015 08:56:25 -0700 (PDT)
Received: from yow-lhowlett-d0.wrs.com (128.224.56.215) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.3.224.2; Fri, 15 May 2015 08:56:25 -0700
From: "Liam R. Howlett" <Liam.Howlett@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 15 May 2015 11:56:23 -0400
Message-ID: <1431705384-7866-1-git-send-email-Liam.Howlett@WindRiver.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Cc: Liam.Howlett@WindRiver.com
Subject: [PATCH] fetch2: Allow GIT_SMART_HTTP to be passed through to the fetcher.
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
X-List-Received-Date: Fri, 15 May 2015 15:56:26 -0000
Content-Type: text/plain


Older servers may not be able to use GIT_SMART_HTTP transport.  This allows the
GIT_SMART_HTTP variable to be exported to the fetch command so users can set
this to zero if required.

Liam R. Howlett (1):
  fetch2: Allow GIT_SMART_HTTP to be passed through

 lib/bb/fetch2/__init__.py | 1 +
 1 file changed, 1 insertion(+)

-- 
2.1.1


