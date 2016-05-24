Return-Path: <leonardo.sandoval.gonzalez@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id E5578606D1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 May 2016 14:13:31 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP; 24 May 2016 07:08:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,359,1459839600"; d="scan'208";a="708153314"
Received: from lsandov1-mobl2.zpn.intel.com (HELO [10.219.5.35])
	([10.219.5.35])
	by FMSMGA003.fm.intel.com with ESMTP; 24 May 2016 07:08:30 -0700
To: Markus Lehtonen <markus.lehtonen@linux.intel.com>,
	bitbake-devel@lists.openembedded.org
References: <1464074730-23187-1-git-send-email-markus.lehtonen@linux.intel.com>
From: Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>
Message-ID: <35bff996-f13e-f7d3-4a85-ec710cbc61f8@linux.intel.com>
Date: Tue, 24 May 2016 09:09:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <1464074730-23187-1-git-send-email-markus.lehtonen@linux.intel.com>
Subject: Re: [PATCH] cookerdata: print an error if layer dir does not exist
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
X-List-Received-Date: Tue, 24 May 2016 14:13:32 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit



On 05/24/2016 02:25 AM, Markus Lehtonen wrote:
> Makes it easier for user to identify problems, e.g. typos, in BBLAYERS.
>
> [YOCTO #9507]
>
> Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
> ---
>   lib/bb/cookerdata.py | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
> index 1615db5..7dfe7b5 100644
> --- a/lib/bb/cookerdata.py
> +++ b/lib/bb/cookerdata.py
> @@ -292,6 +292,10 @@ class CookerDataBuilder(object):
>               data = bb.data.createCopy(data)
>               approved = bb.utils.approved_variables()
>               for layer in layers:
> +                if not os.path.isdir(layer):
> +                    parselog.critical("Layer directory '%s' does not to exist! "
> +                                      "Please check BBLAYERS in %s" % (layer, layerconf))
> +                    sys.exit(1)

Markus, I am not familiar with this code, but instead of a sys.exit(1), 
would it be better to raise a exception instead (raise SystemExit(msg))?

>                   parselog.debug(2, "Adding layer %s", layer)
>                   if 'HOME' in approved and '~' in layer:
>                       layer = os.path.expanduser(layer)


