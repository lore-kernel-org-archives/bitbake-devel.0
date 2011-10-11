Received: from mga12.intel.com ([143.182.124.36] helo=azsmga102.ch.intel.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <scott.a.garman@intel.com>) id 1RDg5l-0007A9-MS
	for bitbake-devel@lists.openembedded.org;
	Tue, 11 Oct 2011 19:26:13 +0200
Received: from mail-vx0-f180.google.com ([209.85.220.180])
	by mga14.intel.com with ESMTP/TLS/RC4-SHA; 11 Oct 2011 10:19:25 -0700
Received: by vcbf11 with SMTP id f11so9172853vcb.25
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Oct 2011 10:19:24 -0700 (PDT)
Received: by 10.68.0.5 with SMTP id 5mr47339530pba.118.1318353564438;
	Tue, 11 Oct 2011 10:19:24 -0700 (PDT)
Received: from [192.168.1.12] (c-98-246-160-155.hsd1.or.comcast.net.
	[98.246.160.155])
	by mx.google.com with ESMTPS id ml4sm868779pbc.0.2011.10.11.10.19.19
	(version=SSLv3 cipher=OTHER); Tue, 11 Oct 2011 10:19:19 -0700 (PDT)
Message-ID: <4E947A96.9000800@intel.com>
Date: Tue, 11 Oct 2011 10:19:18 -0700
From: Scott Garman <scott.a.garman@intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US;
	rv:1.9.2.23) Gecko/20110922 Lightning/1.0b2 Thunderbird/3.1.15
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <cover.1318352470.git.josh@linux.intel.com>
In-Reply-To: <cover.1318352470.git.josh@linux.intel.com>
Subject: Re: [PATCH 0/2] Improve usability of checksums
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
X-List-Received-Date: Tue, 11 Oct 2011 17:26:14 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 10/11/2011 10:07 AM, Joshua Lock wrote:
> I'd heard some complaints around the usability of checksums and, having done
> some recipe work recently, must agree with them.
> This series ams to make using checksums less intrusive by:
>
> a) Removing the requirement that if one type of checksum is defined the other
> must be too.
> b) Reporting all sum mismatches at once
> c) Enabling sums to be defined as a parameter of a SRC_URI

Very nice, thank you!

Acked-by: Scott Garman <scott.a.garman@intel.com>

-- 
Scott Garman
Embedded Linux Engineer - Yocto Project
Intel Open Source Technology Center


