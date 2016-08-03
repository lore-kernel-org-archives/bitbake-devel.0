Return-Path: <Liam.Howlett@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 6D2B273243
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Aug 2016 19:57:52 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id u73JvrYm019330
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 3 Aug 2016 12:57:53 -0700
Received: from yow-lhowlett-d0.wrs.com (128.224.56.205) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
	14.3.248.2; Wed, 3 Aug 2016 12:57:50 -0700
From: "Liam R. Howlett" <Liam.Howlett@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 3 Aug 2016 15:57:48 -0400
Message-ID: <1470254270-5368-1-git-send-email-Liam.Howlett@WindRiver.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Cc: Liam.Howlett@WindRiver.com
Subject: [PATCH 0/2] bin/toaster: clean up unnecessary if statement and zsh fix.
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
X-List-Received-Date: Wed, 03 Aug 2016 19:57:53 -0000
Content-Type: text/plain

Remove an unnecessary if statement that was left over from a change to a case
statement and set a required zsh setting for the existing code to work more
reliably.

Liam R. Howlett (2):
  bin/toaster: Remove extra CMD check.
  bin/toaster: set shwordsplit if using zsh.

 bin/toaster | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

-- 
1.9.1


