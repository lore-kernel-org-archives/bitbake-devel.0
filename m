Received: from mail-yw0-f47.google.com ([209.85.213.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <raj.khem@gmail.com>) id 1Qozwm-0004qy-SO
	for bitbake-devel@lists.openembedded.org;
	Thu, 04 Aug 2011 17:34:57 +0200
Received: by ywe9 with SMTP id 9so1167946ywe.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 04 Aug 2011 08:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=message-id:date:from:user-agent:mime-version:to:subject:references
	:in-reply-to:content-type:content-transfer-encoding;
	bh=eFnCP6HZT89oUWhfrgqwBbVlWcE70/CGRhivZ/y+ZVg=;
	b=KEq19lb75hohFy65HShdWp0Diw4VaSQFSvPW5a5JdJXTZ9En9uf8IlgDsyVEf0WBlC
	6KRG44u4MU4NwB4oR4h7SsFYSGkHdKp5VcPWUDivTXTxYW01HVbJdbEcvL+Iox9DjKWR
	eYZB2XQliNH41ZHQgh+RTYWcZHm9LpmBSvSVs=
Received: by 10.143.158.11 with SMTP id k11mr378934wfo.161.1312471832223;
	Thu, 04 Aug 2011 08:30:32 -0700 (PDT)
Received: from [192.168.1.70] (99-57-141-118.lightspeed.sntcca.sbcglobal.net
	[99.57.141.118])
	by mx.google.com with ESMTPS id m12sm1281528wfh.19.2011.08.04.08.30.30
	(version=SSLv3 cipher=OTHER); Thu, 04 Aug 2011 08:30:30 -0700 (PDT)
Message-ID: <4E3ABB14.1040203@gmail.com>
Date: Thu, 04 Aug 2011 08:30:28 -0700
From: Khem Raj <raj.khem@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:5.0) Gecko/20110627 Thunderbird/5.0
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <C10D3FB0CD45994C8A51FEC1227CE22F2CE2E480D0@shsmsx502.ccr.corp.intel.com>
In-Reply-To: <C10D3FB0CD45994C8A51FEC1227CE22F2CE2E480D0@shsmsx502.ccr.corp.intel.com>
Subject: Re: when does ${XX} in variable names get expanded?
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
X-List-Received-Date: Thu, 04 Aug 2011 15:34:57 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 08/04/2011 02:19 AM, Lu, Lianhao wrote:
> Hi guys,
>
> For the following variable definition in bitbake,
>
> VVV = "llu"
> A_${VVV} = "VVV"
> A_llu = "llu"
>
> B = "${@bb.data.getVar('A_llu', d, True)}"
> C := "${@bb.data.getVar('A_llu', d, True)}"
>
> Why B is "VVV" and C is "llu" in final? I'm wondering when is the ${VVV} in the variable name of A_${VVV} expanded.
>

:= demands immediate expansion so any variables thats in the expression 
will be evaluated right there

where as = will be evaluated on reference and the variables it uses will 
be read/evaluated at that time.

> Best Regards,
> -Lianhao Lu
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel



