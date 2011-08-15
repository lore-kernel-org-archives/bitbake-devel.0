Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Qssof-0007YM-3v for bitbake-devel@lists.openembedded.org;
	Mon, 15 Aug 2011 10:46:37 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7F8g0aZ015164;
	Mon, 15 Aug 2011 09:42:00 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 15017-02; Mon, 15 Aug 2011 09:41:56 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7F8fp06015158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 15 Aug 2011 09:41:51 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <0bed22559175a17f0af42f122e719c869f8dc0e7.1313196998.git.josh@linux.intel.com>
References: <cover.1313196998.git.josh@linux.intel.com>
	<0bed22559175a17f0af42f122e719c869f8dc0e7.1313196998.git.josh@linux.intel.com>
Date: Mon, 15 Aug 2011 09:41:48 +0100
Message-ID: <1313397708.14274.544.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [RFC PATCH 1/1] Ensure only the filtered environment variables are inherited from the OS
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
X-List-Received-Date: Mon, 15 Aug 2011 08:46:37 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2011-08-12 at 17:58 -0700, Joshua Lock wrote:
> The recent change which modified inheritFromOS to use the intial
> environment, rather than the current environment, introduced a bug such
> that variables which had been cleaned from the environment where still set
> in the data store.
> 
> This patch changes things such that a list of approved environment
> variables is saved after the environment is cleaned and only the variables
> in this list are inherited in inheritFromOS.
> 
> CC: James Limbouris <james.limbouris@gmail.com>
> CC: Chris Larson <clarson@kergoth.com>
> Signed-off-by: Joshua Lock <josh@linux.intel.com>
> ---
>  bin/bitbake-layers |    6 +++---
>  lib/bb/cooker.py   |    3 ++-
>  lib/bb/data.py     |   15 ++++++++-------
>  lib/bb/utils.py    |   23 ++++++++++++++++-------
>  4 files changed, 29 insertions(+), 18 deletions(-)

Merged to master, thanks.

Richard





