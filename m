Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 519B47873C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 20 Feb 2018 12:08:24 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w1KC8K7r002384
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Tue, 20 Feb 2018 12:08:21 GMT
Message-ID: <1519128500.24236.291.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Stephano Cetola <stephano.cetola@linux.intel.com>,
	bitbake-devel@lists.openembedded.org
Date: Tue, 20 Feb 2018 12:08:20 +0000
In-Reply-To: <20180219181551.87750-2-stephano.cetola@linux.intel.com>
References: <20180219181551.87750-1-stephano.cetola@linux.intel.com>
	<20180219181551.87750-2-stephano.cetola@linux.intel.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.3 at dan
X-Virus-Status: Clean
Subject: Re: [PATCH V2 1/1] utils.py: Add option for explode_dep_versions2 to return unsorted
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
X-List-Received-Date: Tue, 20 Feb 2018 12:08:25 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Mon, 2018-02-19 at 10:15 -0800, Stephano Cetola wrote:
> From: Amanda Brindle <amanda.r.brindle@intel.com>
> 
> Before, explode_dep_versions2 would sort the OrderedDict before
> returning. This function will still sort the OrderedDict by default,
> but
> will now have the option to return the OrderedDict unsorted. This
> option will
> allow us to check if the order of the package list has changed.
> 
> Signed-off-by: Amanda Brindle <amanda.r.brindle@intel.com>
> Acked-by: Stephano Cetola <stephano.cetola@linux.intel.com>
> ---
>  lib/bb/utils.py | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> index c540b49c..7adb4690 100644
> --- a/lib/bb/utils.py
> +++ b/lib/bb/utils.py
> @@ -187,7 +187,7 @@ def explode_deps(s):
>              #r[-1] += ' ' + ' '.join(j)
>      return r
>  
> -def explode_dep_versions2(s):
> +def explode_dep_versions2(s, unsorted=False):
>      """

Would:

def explode_dep_versions2(s, sorted=True):

make things easier to read/understand?

The 'double' logic there currently confuses me a bit.

Cheers,

Richard



