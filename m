Return-Path: <olof.johansson@axis.com>
Received: from anubis.se.axis.com (anubis.se.axis.com [195.60.68.12])
	by mail.openembedded.org (Postfix) with ESMTP id BC7EB6CB7C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 15:57:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id 3D92219EA9;
	Mon, 20 Jan 2014 16:57:38 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id BuRbQkKUl9sb; Mon, 20 Jan 2014 16:57:36 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by anubis.se.axis.com (Postfix) with ESMTP id 9D6D019E9D;
	Mon, 20 Jan 2014 16:57:36 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 535BEC84;
	Mon, 20 Jan 2014 16:57:36 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id 45FF8BB5;
	Mon, 20 Jan 2014 16:57:36 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id 432C23E06F;
	Mon, 20 Jan 2014 16:57:36 +0100 (CET)
Received: from axis.com (10.92.17.1) by xmail2.se.axis.com (10.0.5.74) with
	Microsoft SMTP Server (TLS) id 8.2.255.0;
	Mon, 20 Jan 2014 16:57:35 +0100
Date: Mon, 20 Jan 2014 16:57:34 +0100
From: Olof Johansson <olof.johansson@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20140120155734.GI6520@axis.com>
References: <1390231311.874.37.camel@ted>
MIME-Version: 1.0
In-Reply-To: <1390231311.874.37.camel@ted>
User-Agent: Mutt/1.5.22 (2013-10-16)
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch2/git: Anchor names when using ls-remote
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
X-List-Received-Date: Mon, 20 Jan 2014 15:57:44 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On 14-01-20 16:21 +0100, Richard Purdie wrote:
> When specifying tags, they're searched for unanchored so foo/bar could
> match:
> 
> refs/heads/abc/foo/bar
> refs/heads/xyz/foo/bar
> refs/heads/foo/bar
> 
> This change anchors the expressions so they are based against heads
> or tags (or any other base level tree that has been created).

Afaict, ls-remote matches the wildcard character against any
character, including /.

$ git ls-remote gittest refs/*/foo/bar
69ab4bdbb5f3725ca594a2abdb636ee8fc25e1c4        refs/tags/abc/foo/bar
c8647b027d88af180e90d842577518b73ef6a167        refs/tags/foo/bar
149c3c329515086af1ae4e24b12b17100ae16256        refs/tags/xyz/foo/bar

-- 
olofjn

