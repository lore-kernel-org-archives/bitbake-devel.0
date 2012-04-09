Received: from hermes.mlbassoc.com ([64.234.241.98] helo=mail.chez-thomas.org)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <gary@mlbassoc.com>) id 1SHEOx-0007H8-90
	for bitbake-devel@lists.openembedded.org;
	Mon, 09 Apr 2012 15:12:59 +0200
Received: by mail.chez-thomas.org (Postfix, from userid 1998)
	id 9FF36F8124E; Mon,  9 Apr 2012 07:03:43 -0600 (MDT)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	hermes.chez-thomas.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.2
Received: from hermes.chez-thomas.org (localhost.localdomain [127.0.0.1])
	by mail.chez-thomas.org (Postfix) with ESMTP id DAEEEF8123F;
	Mon,  9 Apr 2012 07:03:42 -0600 (MDT)
Message-ID: <4F82DE2E.30208@mlbassoc.com>
Date: Mon, 09 Apr 2012 07:03:42 -0600
From: Gary Thomas <gary@mlbassoc.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:11.0) Gecko/20120329 Thunderbird/11.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
Subject: bblayers.conf is required?
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
X-List-Received-Date: Mon, 09 Apr 2012 13:12:59 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The config file conf/bblayers.conf seems to be required:
   $ bitbake core-image-minimal
   Unable to find conf/bblayers.conf
   BitBake must be run from within your build directory: /home/local/p60_poky

but the bitbake documentation says otherwise:
                 <para>BitBake will first search the current working directory for an optional "conf/bblayers.conf" configuration file. This file is expected to contain a BBLAYERS 
variable which is a space delimited list of 'layer' directories. For each directory in this list, a "conf/layer.conf" file will be searched for and parsed with the LAYERDIR 
variable being set to the directory where the layer was found. The idea is these files will setup BBPATH and other variables correctly for a given build directory automatically for 
the user.</para>

Maybe the documentation should just read "required" instead of "optional"?

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------


