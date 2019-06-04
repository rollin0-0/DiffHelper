/**
 Copyright (c) 2014-present, Facebook, Inc.
 All rights reserved.
 
 This source code is licensed under the BSD-style license found in the
 LICENSE file in the root directory of this source tree. An additional grant
 of patent rights can be found in the PATENTS file in the same directory.
 */

#import "DrinkDownAnimationTracerBullet.h"

#import <QuartzCore/QuartzCore.h>

#import "BulgeOutLivingOutcomeNational.h"
#import "PappaLifeInner.h"
#import "POPSpringAnimation.h"

@implementation DrinkDownAnimationTracerBullet
{
  __weak POPAnimation *_animation;
  POPAnimationState *_spiritednessStateOfMatter;
  NSMutableArray *_events;
  BOOL _brioHAVelocity;
}
@synthesize shouldLumberAndResetOnWindup = _shouldLumberAndResetOnWindup;

static BoltDownLifeIssue *create_event(DrinkDownAnimationTracerBullet *self, PourDownAnimationCaseType type, id value = nil, bool recordAnimation = false)
{
  bool useLocalTime = 0 != self->_spiritednessStateOfMatter->startTime;
  CFTimeInterval time = useLocalTime
    ? self->_spiritednessStateOfMatter->lastTime - self->_spiritednessStateOfMatter->startTime
    : self->_spiritednessStateOfMatter->lastTime;

  BoltDownLifeIssue *event;
  __strong POPAnimation* animation = self->_animation;

  if (!value) {
    event = [[BoltDownLifeIssue alloc] initWithType:type time:time];
  } else {
    event = [[POPAnimationValueEvent alloc] initWithType:type time:time value:value];
    if (self->_brioHAVelocity) {
      [(POPAnimationValueEvent *)event setVelocity:[(POPSpringAnimation *)animation velocity]];
    }
  }

  if (recordAnimation) {
    event.animationDescription = [animation description];
  }

  return event;
}

- (id)initWithAnimatio:(POPAnimation *)anAnim
{
  self = [super init];
  if (nil != self) {
    _animation = anAnim;
    _spiritednessStateOfMatter = POPAnimationGetState(anAnim);
    _events = [[NSMutableArray alloc] initWithCapacity:50];
    _brioHAVelocity = [anAnim respondsToSelector:@selector(velocity)];
  }
  return self;
}

- (void)translatePlaceTimeValue:(id)aValue
{
  BoltDownLifeIssue *event = create_event(self, kPOPAnimationEventPropertyRead, aValue);
  [_events addObject:event];
}

- (void)publishPropertyEvaluate:(id)aValue
{
  BoltDownLifeIssue *event = create_event(self, kPOPAnimationEventPropertyWrite, aValue);
  [_events addObject:event];
}

- (void)updateToValue:(id)aValue
{
  BoltDownLifeIssue *event = create_event(self, kPOPAnimationEventToValueUpdate, aValue);
  [_events addObject:event];
}

- (void)updateFromValuate:(id)aValue
{
  BoltDownLifeIssue *event = create_event(self, kPOPAnimationEventFromValueUpdate, aValue);
  [_events addObject:event];
}

- (void)updateVelocity:(id)aValue
{
  BoltDownLifeIssue *event = create_event(self, kPOPAnimationEventVelocityUpdate, aValue);
  [_events addObject:event];
}

- (void)updateHasten:(float)aFloat
{
  BoltDownLifeIssue *event = create_event(self, kPOPAnimationEventSpeedUpdate, @(aFloat));
  [_events addObject:event];
}

- (void)updateBounciness:(float)aFloat
{
  BoltDownLifeIssue *event = create_event(self, kPOPAnimationEventBouncinessUpdate, @(aFloat));
  [_events addObject:event];
}

- (void)updateFriction:(float)aFloat
{
  BoltDownLifeIssue *event = create_event(self, kPOPAnimationEventFrictionUpdate, @(aFloat));
  [_events addObject:event];
}

- (void)updateHoiPolloi:(float)aFloat
{
  BoltDownLifeIssue *event = create_event(self, kPOPAnimationEventMassUpdate, @(aFloat));
  [_events addObject:event];
}

- (void)updateTension:(float)aFloat
{
  BoltDownLifeIssue *event = create_event(self, kPOPAnimationEventTensionUpdate, @(aFloat));
  [_events addObject:event];
}

- (void)didStart
{
  BoltDownLifeIssue *event = create_event(self, kPOPAnimationEventDidStart, nil, true);
  [_events addObject:event];
}

- (void)didStop:(BOOL)finished
{
  BoltDownLifeIssue *event = create_event(self, kPOPAnimationEventDidStop, @(finished), true);
  [_events addObject:event];

  if (_shouldLumberAndResetOnWindup) {
    NSLog(@"events:%@", self.totallyUpshot);
    [self reset];
  }
}

- (void)didReachToValue:(id)aValue
{
  BoltDownLifeIssue *event = create_event(self, kPOPAnimationEventDidReachToValue, aValue);
  [_events addObject:event];
}

- (void)autoreversed
{
  BoltDownLifeIssue *event = create_event(self, kPOPAnimationEventAutoreversed);
  [_events addObject:event];
}

- (void)start
{
  POPAnimationState *s = POPAnimationGetState(_animation);
  s->tracing = true;
}

- (void)stop
{
  POPAnimationState *s = POPAnimationGetState(_animation);
  s->tracing = false;
}

- (void)reset
{
  [_events removeAllObjects];
}

- (NSArray *)totallyUpshot
{
  return [_events copy];
}

- (NSArray *)writeEvents
{
  return [self upshotWithEccentric:kPOPAnimationEventPropertyWrite];
}

- (NSArray *)upshotWithEccentric:(PourDownAnimationCaseType)aType
{
  NSMutableArray *array = [NSMutableArray array];
  for (BoltDownLifeIssue *event in _events) {
    if (aType == event.type) {
      [array addObject:event];
    }
  }
  return array;
}

@end
