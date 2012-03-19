Received: from astoria.ccjclearline.com ([64.235.106.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rpjday@crashcourse.ca>) id 1S9aZV-0005PR-NK
	for bitbake-devel@lists.openembedded.org;
	Mon, 19 Mar 2012 12:16:17 +0100
Received: from cpec03f0ed08c7f-cm001ac318e826.cpe.net.cable.rogers.com
	([99.241.91.63] helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69) (envelope-from <rpjday@crashcourse.ca>)
	id 1S9aQx-0006xP-LS for bitbake-devel@lists.openembedded.org;
	Mon, 19 Mar 2012 07:07:27 -0400
Date: Mon, 19 Mar 2012 07:07:18 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@oneiric
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.DEB.2.02.1203190704390.20606@oneiric>
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
Subject: "bitbake-layers show-overlayed" generates python traceback
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
X-List-Received-Date: Mon, 19 Mar 2012 11:16:17 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


  just goofing around with a utility i'd never noticed before,
bitbake-layers, and tested it on a simple qemux86 configuration:

$ bitbake-layers show-overlayed
Parsing recipes..done.
Traceback (most recent call last):
  File "/home/rpjday/oe/oe-core/bitbake/bin/bitbake-layers", line 593, in <module>
    sys.exit(main(sys.argv[1:]) or 0)
  File "/home/rpjday/oe/oe-core/bitbake/bin/bitbake-layers", line 47, in main
    cmds.onecmd(' '.join(args))
  File "/usr/lib/python2.7/cmd.py", line 219, in onecmd
    return func(arg)
  File "/home/rpjday/oe/oe-core/bitbake/bin/bitbake-layers", line 216, in do_show_overlayed
    logger.note('No overlayed files found')
AttributeError: 'BBLogger' object has no attribute 'note'
$

  is there a special context i need to run this in?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================


