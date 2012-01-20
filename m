Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RoHdo-0003uB-Nd for bitbake-devel@lists.openembedded.org;
	Fri, 20 Jan 2012 17:48:40 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0KGewcW020227;
	Fri, 20 Jan 2012 16:40:58 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 19825-07; Fri, 20 Jan 2012 16:40:53 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0KGepV9020221
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 Jan 2012 16:40:52 GMT
Message-ID: <1327077650.4268.16.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Fri, 20 Jan 2012 16:40:50 +0000
In-Reply-To: <a996be9518b7cd4a9fa50958be65dbd63380c8ca.1326982052.git.paul.eggleton@linux.intel.com>
References: <cover.1326982052.git.paul.eggleton@linux.intel.com>
	<a996be9518b7cd4a9fa50958be65dbd63380c8ca.1326982052.git.paul.eggleton@linux.intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] bitbake/runqueue: always log tasks summary
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
X-List-Received-Date: Fri, 20 Jan 2012 16:48:41 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-01-19 at 14:36 +0000, Paul Eggleton wrote:
> It's unclear from the history but at some point we stopped logging the
> "Tasks Summary" NOTE when tasks failed. Reinstate this for failure, and
> also make the count of attempted tasks include the failed task.
> 
> Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
> ---
>  bitbake/lib/bb/runqueue.py |   12 +++++++-----
>  1 files changed, 7 insertions(+), 5 deletions(-)

Merged to master, thanks.

Richard



