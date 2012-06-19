Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1Sgx16-00050s-6b
	for bitbake-devel@lists.openembedded.org;
	Tue, 19 Jun 2012 13:54:40 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q5JBhtQl000351
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 19 Jun 2012 04:43:55 -0700 (PDT)
Received: from [172.25.32.41] (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Tue, 19 Jun 2012 04:43:55 -0700
Message-ID: <4FE065F9.6010300@windriver.com>
Date: Tue, 19 Jun 2012 06:43:53 -0500
From: Jason Wessel <jason.wessel@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:12.0) Gecko/20120430 Thunderbird/12.0.1
MIME-Version: 1.0
To: Paul Eggleton <paul.eggleton@linux.intel.com>
References: <cover.1340034255.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1340034255.git.paul.eggleton@linux.intel.com>
X-Enigmail-Version: 1.4.2
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/2] Signature-based rebuild improvements
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
X-List-Received-Date: Tue, 19 Jun 2012 11:54:40 -0000
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On 06/18/2012 10:45 AM, Paul Eggleton wrote:
> The following changes (against poky, but apply cleanly with -p2 against
> bitbake master) are available in the git repository at:
> 
>   git://git.yoctoproject.org/poky-contrib paule/bb-forcebuild
>   http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-forcebuild
> 
> Paul Eggleton (2):
>   bitbake: ensure -f causes dependent tasks to be re-run
>   bitbake: add -C option to invalidate a task and rebuild the target
> 
>  bitbake/bin/bitbake        |    3 +++
>  bitbake/lib/bb/build.py    |   18 ++++++++++++++++++
>  bitbake/lib/bb/cooker.py   |    6 +++---
>  bitbake/lib/bb/runqueue.py |   28 ++++++++++++++++++++++------
>  bitbake/lib/bb/siggen.py   |   35 +++++++++++++++++++++++++++++++++++
>  5 files changed, 81 insertions(+), 9 deletions(-)
> 


While the use cases described in the defect work, there is a new side effect.  The sstate dir starts to fill up with new sums for the what ever package you compile.  Perhaps this is some kind of trade off we have to live with, but I do thing it is worth discussing.

I start with a fully populated sstate.  I didn't make any code changes at all to any package, I just wanted to see the compile log from acl in this case.

    bitbake -f -c compile acl
    bitbake acl

The sstate sum is completely different due to the hash injection, but the code compiled for everything is the same.  There is probably no easy, cheap (as in cpu/wall time) way to have the best of both worlds.

Jason.


