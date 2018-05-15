Return-Path: <bela@becker.rocks>
Received: from becker.rocks (catv-188-142-200-211.catv.broadband.hu
	[188.142.200.211])
	by mail.openembedded.org (Postfix) with ESMTP id BF58B74E86
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 May 2018 13:11:07 +0000 (UTC)
Received: from maxion.localnet (catv-89-133-30-81.catv.broadband.hu
	[89.133.30.81]) by becker.rocks (Postfix) with ESMTPSA id DB376E0205
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 May 2018 15:11:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=becker.rocks; s=mail;
	t=1526389867; bh=5rFbdggahv9mWmd7R4XEZq0nQK5HAfzXOnGIaA3R3UM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MqqaQV4uhMcRaa66aRLt6g1cu1Ljct+DJAWtk/d/kZa1GWXq6rGGfw1C3cgByqiWW
	9EqrCNU3cieCiKkHStp/esdcTRYOI2v3RIbtxMfsJ1KAGzx2ZvNaCpM81JTE0BhLbe
	O3cWSBCt3I3MquJ8U6WCcYLAVR7hlq9Ri7o8cxmE=
From: Becker =?ISO-8859-1?Q?B=E9la?= <bela@becker.rocks>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 15 May 2018 15:11:07 +0200
Message-ID: <4142408.DOWd2aIxmE@maxion>
In-Reply-To: <4772545.pSEQItiHMW@maxion>
References: <4772545.pSEQItiHMW@maxion>
MIME-Version: 1.0
Subject: Re: Forcing a task to run depending on the output of a python script?
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
X-List-Received-Date: Tue, 15 May 2018 13:11:08 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Replying to myself because I figured it out.

If you ever need such functionality, just add a git type SRC_REV pointing to your local repo with the "usehead" option set, and use AUTOREV.

e.g.
    SRC_URI = "git://${THISDIR}/../..;usehead=1;bareclone=1"
    SRCREV = "${AUTOREV}"

"${THISDIR}/../.." looks dirty, but unfortunately ${LAYERDIR} is unavailable outside layer.conf

Cheers to everyone. I hope somebody will find this useful.



