Received: from giant.haxx.se ([80.67.6.50])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <bjst@giant.haxx.se>) id 1ShhoH-00089s-9G
	for bitbake-devel@lists.openembedded.org;
	Thu, 21 Jun 2012 15:52:33 +0200
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id q5LDfelx008995
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 21 Jun 2012 15:41:40 +0200
Received: (from bjst@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) id q5LDfeXo008994;
	Thu, 21 Jun 2012 15:41:40 +0200
Date: Thu, 21 Jun 2012 15:41:40 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Stenberg <bjst@enea.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Message-ID: <20120621134140.GH7204@giant>
References: <cover.1340034255.git.paul.eggleton@linux.intel.com>
	<1756623.6zWylpP7a0@helios> <20120621112555.GD7204@giant>
	<1778547.OMx1BrFPz0@helios> <20120621122637.GF7204@giant>
MIME-Version: 1.0
In-Reply-To: <20120621122637.GF7204@giant>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-MIME-Autoconverted: from 8bit to quoted-printable by giant.haxx.se id
	q5LDfelx008995
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
X-List-Received-Date: Thu, 21 Jun 2012 13:52:33 -0000
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Bj=F6rn Stenberg wrote:
> c) A clear information message when using -f, maybe something like "INF=
O:
> Tainting the hash to force a rebuild", that alerts the user to the goin=
gs-on
> under the hood.

Another thing: How will bitbake-diffsigs show a tainted build vs the unta=
ined version? It would be very nice if that could be shown clearly.

--=20
Bj=F6rn


