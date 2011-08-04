Received: from [93.97.173.237] (helo=tim.rpsys.net)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Qouce-00038H-Qw for bitbake-devel@lists.openembedded.org;
	Thu, 04 Aug 2011 11:53:49 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p749nNuf000606;
	Thu, 4 Aug 2011 10:49:23 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 30999-10; Thu,  4 Aug 2011 10:49:19 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p749nDqU000600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 4 Aug 2011 10:49:15 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Lu, Lianhao" <lianhao.lu@intel.com>
In-Reply-To: <C10D3FB0CD45994C8A51FEC1227CE22F2CE2E480D0@shsmsx502.ccr.corp.intel.com>
References: <C10D3FB0CD45994C8A51FEC1227CE22F2CE2E480D0@shsmsx502.ccr.corp.intel.com>
Date: Thu, 04 Aug 2011 10:48:53 +0100
Message-ID: <1312451333.2344.723.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
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
X-List-Received-Date: Thu, 04 Aug 2011 09:53:49 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2011-08-04 at 17:19 +0800, Lu, Lianhao wrote:
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

During finalise() there is a call to d.expandKeys(). That call will
cause A_${VVV} to overwrite A_llu. If you look at the variable before
that you will get one value, if you look at it after that you will see
the other.

In your example above := is the immediate assignment/expansion operator,
"immediate" being the key part so finalise() hasn't happened yet.

Cheers,

Richard



