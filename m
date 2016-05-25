Return-Path: <andrew@bradfordembedded.com>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
	[66.111.4.26])
	by mail.openembedded.org (Postfix) with ESMTP id BCC7B73176
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 May 2016 19:53:33 +0000 (UTC)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 3E33021511;
	Wed, 25 May 2016 15:48:31 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
	by compute7.internal (MEProxy); Wed, 25 May 2016 15:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	bradfordembedded.com; h=cc:date:from:message-id:subject:to
	:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=EDNpiBlmFbKseb8tub6SHuf+LRs
	=; b=rJG6bDZK4fZHZUB9+4vUc+FaaH3J1hPTrClHjMA1qPADHUDDb0tX5J+WQdZ
	c3psFEqbLMKbeDo2DhVnEUtFCz2fTlNauBymSfw7MowCV8aly1mwsXv9IV6aDqKM
	Y+ujaZlQjE7CH4z+UCnH8NADMr8n8HCV7E+f6my8aQUWS5iI=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:message-id:subject:to
	:x-sasl-enc:x-sasl-enc; s=smtpout; bh=EDNpiBlmFbKseb8tub6SHuf+LR
	s=; b=HM36IsKdv2gYW2cWyJa/aMUqv1PtvQiEPIQeUUNUXJMFo6U6vQgdRy+1oU
	LhbvCzIzxvffjIMMWl+v5JM1BG7CpRnaysdxTYi1nKIqfUy3Js/Jq8Abs7OK7pdS
	tQxZqXOVQaz9XBA/Grs3QDxqXWLBCm2vkx98Ayq5Qj0wfFfoA=
X-Sasl-enc: lgqzFDaxiT94BzHgE+iJlUW/QX8ZnOprBSHhon/G9iiQ 1464205710
Received: from kaim-eeyore.kodakalaris.net (clr-vpn01.kodakalaris.com
	[198.140.222.129])
	by mail.messagingengine.com (Postfix) with ESMTPA id ECBB7F284B;
	Wed, 25 May 2016 15:48:30 -0400 (EDT)
From: Andrew Bradford <andrew@bradfordembedded.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 25 May 2016 15:48:22 -0400
Message-Id: <1464205704-26377-1-git-send-email-andrew@bradfordembedded.com>
X-Mailer: git-send-email 2.8.1
Cc: Andrew Bradford <andrew.bradford@kodakalaris.com>
Subject: [PATCH 0/2] Enhance and document perforce fetcher
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
X-List-Received-Date: Wed, 25 May 2016 19:53:35 -0000

From: Andrew Bradford <andrew.bradford@kodakalaris.com>

Allow the perforce fetcher to act more like the other source control
fetchers so that it can use AUTOREV and the use of the p4 P4CONFIG
variable to specify many p4 settings.  Also document these changes and
how to use this new implementation of the perforce fetcher.

These patches depend on oe-core patches [1].

[1]:http://lists.openembedded.org/pipermail/openembedded-core/2016-May/122075.html

Andrew Bradford (2):
  perforce fetcher: Rework to support SRCREV and P4CONFIG
  doc: Document use of Perforce fetcher

 .../bitbake-user-manual-fetching.xml               |  72 +++++-
 .../bitbake-user-manual-ref-variables.xml          |  11 +-
 lib/bb/fetch2/__init__.py                          |   3 +-
 lib/bb/fetch2/perforce.py                          | 279 +++++++++++----------
 4 files changed, 226 insertions(+), 139 deletions(-)

-- 
2.8.1


