extends Node2D

func start():
	$MainAnimPlayer.play("Main")

func playClackingAnim():
	$BoilerplateAnim.play("ClackingAnim")

func playFamChillingAnim():
	$BoilerplateAnim.play("FamChilling")
	
func GloinkFlyingHouse():
	$BoilerplateAnim.play("GloinkFlyingHouse")
	
func DadAngry():
	$BoilerplateAnim.play("DadAngry")
	
func MomSurprised():
	$BoilerplateAnim.play("MomSurprised")
	
func MomScreaming():
	$BoilerplateAnim.play("MomScreaming")
	
func GloinkDancing():
	$BoilerplateAnim.play("GloinkDancing")

func HouseCovered():
	$BoilerplateAnim.play("HouseCovered")

func GloinkFlyingApartment():
	$BoilerplateAnim.play("GloinkFlyingApartment")
	
func BobPauses():
	$BoilerplateAnim.play("BobPauses")
	
func BobGroans():
	$BoilerplateAnim.play("BobGroans")

func fadeInAndOut():
	var transparencyTween = create_tween() # make everything visible again
	transparencyTween.tween_property($TransitionCover, "color", Color(1, 1, 1, 1), 1.25)\
		.set_trans(Tween.TRANS_LINEAR)
	
	$FadeTimer.start()

func _on_fade_timer_timeout() -> void:
	var transparencyTween = create_tween() # make everything visible again
	transparencyTween.tween_property($TransitionCover, "color", Color(1, 1, 1, 0), 1.25)\
		.set_trans(Tween.TRANS_LINEAR)
