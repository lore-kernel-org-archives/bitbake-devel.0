Received: from astoria.ccjclearline.com ([64.235.106.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rpjday@crashcourse.ca>) id 1TpTrR-0002g6-1f
	for bitbake-devel@lists.openembedded.org;
	Mon, 31 Dec 2012 02:08:17 +0100
Received: from cpec03f0ed08c7f-cm001ac318e826.cpe.net.cable.rogers.com
	([174.115.5.73]:55945 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1TpTcw-0004Nd-Ph; Sun, 30 Dec 2012 19:53:14 -0500
Date: Sun, 30 Dec 2012 19:53:08 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@oneiric
To: Chris Larson <clarson@kergoth.com>
In-Reply-To: <CABcZANmbHgbDak8-1AMinmzXp=xcqagu2kEkrkrbPsFzmo3=vQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1212301949001.21512@oneiric>
References: <alpine.DEB.2.02.1212301734450.20153@oneiric>
	<CABcZANmbHgbDak8-1AMinmzXp=xcqagu2kEkrkrbPsFzmo3=vQ@mail.gmail.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: what means "this=ignored" in the context of SRC_URI/patch?
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
X-List-Received-Date: Mon, 31 Dec 2012 01:08:26 -0000
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-2087555572-1356915191=:21512"

--8323329-2087555572-1356915191=:21512
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sun, 30 Dec 2012, Chris Larson wrote:

> On Sun, Dec 30, 2012 at 3:45 PM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>       i've poked around and checked logs and i have no idea what
>       "this=ignored" means.  is it an earlier equivalent of "apply=no"?
>       i've never run across it being used anywhere.
>
>
> Never heard of such a thing, personally.

  ok, so that can be safely removed from the bitbake manual.

>         and while we're on the topic, i'm assuming adding "apply=yes" is
>       utterly redundant, yes?  even though there are a bunch of them
>       sprinkled throughout some recipes in oe-core.
>
> As has been mentioned before, apply=yes is only implicit and
> automatic when the filename ends in .{patch,diff}{,.gz}.

  while i'm not a python expert, i'm not convinced.  here's the code
from patch.bbclass:

def patch_path(url, fetch, workdir):
    """Return the local path of a patch, or None if this isn't a patch"""

    local = fetch.localpath(url)
    base, ext = os.path.splitext(os.path.basename(local))
    if ext in ('.gz', '.bz2', '.Z'):
        local = os.path.join(workdir, base)
        ext = os.path.splitext(base)[1]

    urldata = fetch.ud[url]
    if "apply" in urldata.parm:
        apply = oe.types.boolean(urldata.parm["apply"])
        if not apply:
            return
    elif ext not in (".diff", ".patch"):
        return
    ... snip ...

i notice that the value of "apply" is tested *before* the final test
for a valid patch suffix of {.patch,.diff}, which leaves open the
possibility of something weird or obscure happening there?  i have no
idea what that might be, i'm just observing the order of those tests.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

--8323329-2087555572-1356915191=:21512--
