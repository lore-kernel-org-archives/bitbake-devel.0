Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 357F061037
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Aug 2013 20:18:40 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7DKTbho020024; Tue, 13 Aug 2013 21:29:37 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id sjqbqzm2ecKE; Tue, 13 Aug 2013 21:29:36 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7DKTW1m020019
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Tue, 13 Aug 2013 21:29:33 +0100
Message-ID: <1376425098.1838.27.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Tue, 13 Aug 2013 21:18:18 +0100
In-Reply-To: <3da24015e63e0ed7223d668790027ede24a5c02e.1376403450.git.paul.eggleton@linux.intel.com>
References: <cover.1376403450.git.paul.eggleton@linux.intel.com>
	<3da24015e63e0ed7223d668790027ede24a5c02e.1376403450.git.paul.eggleton@linux.intel.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/2] runqueue: report close matches for an invalid task name
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
X-List-Received-Date: Tue, 13 Aug 2013 20:18:42 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2013-08-13 at 15:18 +0100, Paul Eggleton wrote:
> Help to pick up mistakes such as "bitbake -c cleanstate xyz" (instead
> of "bitbake -c cleansstate xyz".)
> 
> Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
> ---
>  bitbake/lib/bb/runqueue.py | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index b2c9703..b3374f1 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -601,7 +601,11 @@ class RunQueueData:
>                  continue
>  
>              if target[1] not in taskData.tasks_lookup[fnid]:
> -                bb.msg.fatal("RunQueue", "Task %s does not exist for target %s" % (target[1], target[0]))
> +                import difflib
> +                close_matches = difflib.get_close_matches(target[1], taskData.tasks_lookup[fnid], cutoff=0.7)
> +                if close_matches:
> +                    extra = ". Close matches:\n  %s" % "\n  ".join(close_matches)
> +                bb.msg.fatal("RunQueue", "Task %s does not exist for target %s%s" % (target[1], target[0], extra))

Missing else: extra = ""?

Cheers,

Richard


