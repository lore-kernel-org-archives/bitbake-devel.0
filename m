Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id BC42871C7E
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jan 2017 19:52:51 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v0CJqgoA003357
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 12 Jan 2017 11:52:42 -0800 (PST)
Received: from soho-mhatle-m.local (172.25.36.235) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.294.0;
	Thu, 12 Jan 2017 11:52:42 -0800
To: Juro Bystricky <juro.bystricky@intel.com>,
	<bitbake-devel@lists.openembedded.org>
References: <1484249037-36445-1-git-send-email-juro.bystricky@intel.com>
	<1484249037-36445-2-git-send-email-juro.bystricky@intel.com>
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
Message-ID: <e1da4ee5-4165-7d25-7811-5fba37607eb3@windriver.com>
Date: Thu, 12 Jan 2017 13:52:40 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:45.0)
	Gecko/20100101 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <1484249037-36445-2-git-send-email-juro.bystricky@intel.com>
Cc: jurobystricky@hotmail.com
Subject: Re: [PATCH 2/2] sanity.bbclass: Improved error message
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
X-List-Received-Date: Thu, 12 Jan 2017 19:52:52 -0000
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit

On 1/12/17 1:23 PM, Juro Bystricky wrote:
> When a non-existing MACHINE is specified, sanity check issues
> the following message:
> 
>     Please set a valid MACHINE in your local.conf or environment
> 
> However, MACHINE can also be set in multiconfig .conf file(s).
> Hence we may have several different MACHINE settings within one
> (multiconfig) build, so the present error message is fairly
> ambiguous.
> 
> This patch remedies this by explicitly naming the offending MACHINE and
> adding conf/multiconfig/*.conf to the list of places where this erroneous
> MACHINE definition could have originated.
> 
>     Invalid MACHINE=xyz. Please set a valid MACHINE in your local.conf, conf/multiconfig/*.conf or environment

(I don't have any problem with the change, but I do have a suggestion that may
make it better.)

I'm not sure if it's available without specifically using the bitbake -e flag,
but we do usually capture where variables are defined.  Could this be used to
provide a better error message for the user?

i.e. bitbake -e output:

# $MACHINE [3 operations]
#   set /home/mhatle/oe/build/conf/local.conf:76
#     [_defaultval] "qemux86-64"
#   set /home/mhatle/oe/meta/conf/documentation.co
nf:274
#     [doc] "Specifies the target device for which the image is built. You defin
e MACHINE in the conf/local.conf file in the Build Directory."
#   set /home/mhatle/oe/meta/conf/bitbake.conf:795
#     [unexport] "1"
# pre-expansion value:
#   "qemux86-64"
unset MACHINE

in this case it knows it was defined in the local.conf on line 76.

... and if I set it in the environment:

# $MACHINE [4 operations]
#   from env data.py:177 [inheritFromOS]
#     "foobar"
#   set /home/mhatle/oe/build/conf/local.conf:76
#     [_defaultval] "qemux86-64"
#   set /home/mhatle/oe/meta/conf/documentation.co
nf:274
#     [doc] "Specifies the target device for which the image is built. You defin
e MACHINE in the conf/local.conf file in the Build Directory."
#   set /home/mhatle/oe/meta/conf/bitbake.conf:795
#     [unexport] "1"
# pre-expansion value:
#   "foobar"
unset MACHINE

It knows it was 'inheritFromOS'.

--Mark

> [YOCTO#10810]
> 
> Signed-off-by: Juro Bystricky <juro.bystricky@intel.com>
> ---
>  meta/classes/sanity.bbclass | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/meta/classes/sanity.bbclass b/meta/classes/sanity.bbclass
> index c876dc6..8477d38 100644
> --- a/meta/classes/sanity.bbclass
> +++ b/meta/classes/sanity.bbclass
> @@ -823,7 +823,7 @@ def check_sanity_everybuild(status, d):
>      machinevalid = True
>      if d.getVar('MACHINE'):
>          if not check_conf_exists("conf/machine/${MACHINE}.conf", d):
> -            status.addresult('Please set a valid MACHINE in your local.conf or environment\n')
> +            status.addresult('Invalid MACHINE=%s. Please set a valid MACHINE in your local.conf, conf/multiconfig/*.conf or environment\n' % (d.getVar('MACHINE')))
>              machinevalid = False
>          else:
>              status.addresult(check_sanity_validmachine(d))
> 


