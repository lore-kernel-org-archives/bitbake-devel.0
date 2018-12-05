Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 27B1B6BC7E;
	Wed,  5 Dec 2018 22:50:19 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-10) with ESMTPSA id
	wB5MoI4x012618
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Wed, 5 Dec 2018 22:50:19 GMT
Message-ID: <92dc76b3b209f034ebafaf88ae8ff9844475abb9.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Watt <jpewhacker@gmail.com>,
	openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Wed, 05 Dec 2018 22:50:18 +0000
In-Reply-To: <20181204034245.25461-11-JPEWhacker@gmail.com>
References: <20180809220840.26697-1-JPEWhacker@gmail.com>
	<20181204034245.25461-1-JPEWhacker@gmail.com>
	<20181204034245.25461-11-JPEWhacker@gmail.com>
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.100.2 at dan
X-Virus-Status: Clean
Subject: Re: [OE-core][PATCH v3 10/17] bitbake: siggen: Split out task depend ID
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
X-List-Received-Date: Wed, 05 Dec 2018 22:50:20 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2018-12-03 at 21:42 -0600, Joshua Watt wrote:
> Abstracts the function to get the dependency ID for a task so it can
> return something other that the taskhash
> 
> [YOCTO #13030]
> 
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>  bitbake/lib/bb/siggen.py | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
> index ab6df7603c8..2daca70538a 100644
> --- a/bitbake/lib/bb/siggen.py
> +++ b/bitbake/lib/bb/siggen.py
> @@ -41,6 +41,9 @@ class SignatureGenerator(object):
>      def finalise(self, fn, d, varient):
>          return
>  
> +    def get_depid(self, task):
> +        return self.taskhash[task]
> +
>      def get_taskhash(self, fn, task, deps, dataCache):
>          return "0"

I spent a while wondering why we still had "IDs" in the runqueue code
when I thought I'd removed them all. Once I'd gotten over that I
somehow thought this related to the task's dependencies and then how
could it only have one of them?

I therefore suspect calling this "depid" is going to be confusing and
we need a better name for it. I'm wondering about taskresid?
taskresolvid? taskresolvedid? taskreshash?

I appreciate why you're calling it an 'ID', hash may be clearer
thought, not sure...

Cheers,

Richard











