Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1RGZwM-0006yS-Jb
	for bitbake-devel@lists.openembedded.org;
	Wed, 19 Oct 2011 19:28:30 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 19 Oct 2011 10:22:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.69,373,1315206000"; d="scan'208";a="28203369"
Received: from unknown (HELO [10.255.15.35]) ([10.255.15.35])
	by AZSMGA002.ch.intel.com with ESMTP; 19 Oct 2011 10:22:16 -0700
Message-ID: <4E9F0748.3090901@linux.intel.com>
Date: Wed, 19 Oct 2011 10:22:16 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:7.0.1) Gecko/20110930 Thunderbird/7.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <cover.1318352470.git.josh@linux.intel.com>
	<63dc9197eb483863e1cec5e58f036b7493850787.1318352470.git.josh@linux.intel.com>
In-Reply-To: <63dc9197eb483863e1cec5e58f036b7493850787.1318352470.git.josh@linux.intel.com>
Subject: Re: [PATCH 1/2] fetch2: improve usability of checksums
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
X-List-Received-Date: Wed, 19 Oct 2011 17:28:30 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit



On 10/11/2011 10:07 AM, Joshua Lock wrote:
>      if ud.sha256_expected != sha256data:
> -        raise SHA256SumError(ud.localpath, ud.sha256_expected, sha256data, u)
> +        sha256mismatch = True
> +
> +    # We want to alert the user if a checksum is defined in the recipe but
> +    # it does not match.
> +    msg = ""
> +    if md5mismatch and ud.md5_expected:
> +        msg = msg + "\nFile: '%s' has %s checksum %s when %s was expected (from URL: '%s')" % (ud.localpath, 'md5', ud.md5_expected, md5data, u)
> +
> +    if sha256mismatch and ud.sha256_expected:
> +        msg = msg + "\nFile: '%s' has %s checksum %s when %s was expected (from URL: '%s')" % (ud.localpath, 'sha256', ud.sha256_expected, sha256data, u)
> +

Just realised I was passing the expected and data parameters in the
wrong order - I've pushed a fix to the same branch.

Cheers,
Joshua
-- 
Joshua Lock
        Yocto Project "Johannes factotum"
        Intel Open Source Technology Centre


