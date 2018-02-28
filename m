Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 52F506FFA1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Feb 2018 11:27:19 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w1SBRJAf030871
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Wed, 28 Feb 2018 11:27:20 GMT
Message-ID: <1519817239.3436.3.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org, Paul Barker <pbarker@toganlabs.com>
Date: Wed, 28 Feb 2018 11:27:19 +0000
In-Reply-To: <1519814643.24236.418.camel@linuxfoundation.org>
References: <1519768112-25072-1-git-send-email-richard.purdie@linuxfoundation.org>
	<1519814643.24236.418.camel@linuxfoundation.org>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.3 at dan
X-Virus-Status: Clean
Subject: Re: [PATCH] runqueue: Ensure only recursive task dependencies are pruned
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
X-List-Received-Date: Wed, 28 Feb 2018 11:27:20 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2018-02-28 at 10:44 +0000, Richard Purdie wrote:
> We have a problem with this patch since it causes:
> 
> $ oe-selftest -r
> sstatetests.SStateTests.test_sstate_sametune_samesigs
[...]
> =====================================================================
> =
> 2018-02-28 10:36:13,406 - oe-selftest - INFO - FAIL:
> test_sstate_sametune_samesigs (sstatetests.SStateTests)
> 2018-02-28 10:36:13,406 - oe-selftest - INFO - ----------------------

Further investigation suggests this is a metadata bug and bitbake is
right here. Working on a fix for the metadata.

Cheers,

Richard

