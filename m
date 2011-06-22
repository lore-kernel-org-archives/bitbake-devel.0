Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QZPMh-00035Q-4Q for bitbake-devel@lists.openembedded.org;
	Wed, 22 Jun 2011 17:29:15 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p5MFPUwS005213;
	Wed, 22 Jun 2011 16:25:30 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 04944-05; Wed, 22 Jun 2011 16:25:26 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p5MFPLtE005198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 22 Jun 2011 16:25:22 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Scott Garman <scott.a.garman@intel.com>
In-Reply-To: <1308525325-5432-1-git-send-email-scott.a.garman@intel.com>
References: <1308525325-5432-1-git-send-email-scott.a.garman@intel.com>
Date: Wed, 22 Jun 2011 16:25:04 +0100
Message-ID: <1308756304.20015.64.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch2/git.py: improve error reporting when an invalid protocol is used
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 22 Jun 2011 15:29:15 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2011-06-19 at 16:15 -0700, Scott Garman wrote:
> When an invalid 'protocol' parameter is used in a git SRC_URI,
> the error reported was not helpful:
> 
> ERROR: Function 'Fetcher failure for URL: 'None'.
> <environment dump>
> fatal: Could not make temporary directory: No such file or directory
> 
> So instead check that ud.proto is set to something valid, and if not
> raise a meaningful ParameterError which explains that the protocol
> type is the source of the problem.
> 
> This fixes bug [YOCTO #1142]
> 
> Signed-off-by: Scott Garman <scott.a.garman@intel.com>

Merged to master, thanks.

Richard



