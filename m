Received: from giant.haxx.se ([80.67.6.50])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <bjst@giant.haxx.se>) id 1ShFvC-0005tO-NJ
	for bitbake-devel@lists.openembedded.org;
	Wed, 20 Jun 2012 10:05:50 +0200
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id q5K7t4EH011804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 20 Jun 2012 09:55:04 +0200
Received: (from bjst@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) id q5K7t4Vm011800;
	Wed, 20 Jun 2012 09:55:04 +0200
Date: Wed, 20 Jun 2012 09:55:04 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Stenberg <bjst@enea.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Message-ID: <20120620075504.GB22538@giant>
References: <cover.1340034255.git.paul.eggleton@linux.intel.com>
	<dcf1fb0acb4bd3424cbb5f48cd62f4f994896c20.1340034255.git.paul.eggleton@linux.intel.com>
	<20120619193539.GA2530@giant> <4368013.N53ZsVQnoH@helios>
MIME-Version: 1.0
In-Reply-To: <4368013.N53ZsVQnoH@helios>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-MIME-Autoconverted: from 8bit to quoted-printable by giant.haxx.se id
	q5K7t4EH011804
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/2] bitbake: ensure -f causes dependent tasks to be re-run
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
X-List-Received-Date: Wed, 20 Jun 2012 08:05:50 -0000
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Paul Eggleton wrote:
> So my assumption is -f is most often used for the purpose of manually
> forcing a recompile after you have made modifications to the already
> extracted source code under the workdir.

I agree with that.

My concern is based on the fact that people (including myself) don't full=
y know all the details of how bitbake works, and tend to make assumptions=
 based on other build systems they know, such as simple Makefiles.

I think the fact that bitbake sometime works differently means we should =
be extra careful about not playing into devlelopers' assumptions. The bit=
bake option --force sounds rather similar to make's --always-make, especi=
ally when it is described as: "force run of specified cmd, regardless of =
stamp status". While a tangent, the --force parameter in standard unix ut=
ils like cp, mv, rm also matter.

If we were to call it something different instead, like -t/--taint, this =
would avoid some assumptions about its behaviour and make it more clear t=
hat the output will be different even if the input is the same.

Sure, it's not a major issue. But I'm fairly confident that if we keep th=
e option name but change its behaviour, I am going to have to explain mor=
e than once to developers not following this list or the commit logs why =
-f does not do what they think (even though one can argue it never did). =
I'd rather they discover up front that -f is deprecated and that they sho=
uld look up a new option instead.

--=20
Bj=F6rn


