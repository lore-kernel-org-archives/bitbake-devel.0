Return-Path: <pb@pbcl.net>
X-Greylist: delayed 2311 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 12 Oct 2016 17:45:37 UTC
Received: from hetzner.pbcl.net (mail.pbcl.net [88.198.119.4])
	by mail.openembedded.org (Postfix) with ESMTP id 931AA60761
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Oct 2016 17:45:37 +0000 (UTC)
Received: from [2a00:14f0:e04c:51ac:ecb4:a948:3777:ace7] (helo=phil-desktop)
	by hetzner.pbcl.net with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.84)
	(envelope-from <pb@pbcl.net>) id 1buMzj-0001HC-RK
	for bitbake-devel@lists.openembedded.org;
	Wed, 12 Oct 2016 19:07:08 +0200
Message-ID: <1476292027.16008.64.camel@pbcl.net>
From: Phil Blundell <pb@pbcl.net>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 12 Oct 2016 18:07:07 +0100
X-Mailer: Evolution 3.18.3-1 
Mime-Version: 1.0
Subject: Slightly broken exception handling in bb.utils.movefile()
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
X-List-Received-Date: Wed, 12 Oct 2016 17:45:38 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

This code:

        except Exception as e:
            if e[0] != errno.EXDEV:
                # Some random error.
                print("movefile: Failed to move", src, "to", dest, e)
                return None

doesn't seem to work any more (presumably since Python 3).  If you end
up with a PermissionDeniedError here then you get a runtime crash
because PermissionDeniedErrors aren't subscriptable.  

In fact I'm not sure the above was ever quite correct even with Python
2.  I assume that it ought to be a bit more like:

        except OSError as e:
            if e.errno != errno.EXDEV:

p.


