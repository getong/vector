use vector_common::TimeZone;

use crate::{state::Runtime, Target};

/// Accumulative contextual information used at runtime to track state across
/// program execution.
pub struct Context<'a> {
    target: &'a mut dyn Target,
    state: &'a mut Runtime,
    timezone: &'a TimeZone,
}

impl<'a> Context<'a> {
    /// Create a new [`Context`].
    pub fn new(target: &'a mut dyn Target, state: &'a mut Runtime, timezone: &'a TimeZone) -> Self {
        Self {
            target,
            state,
            timezone,
        }
    }

    /// Get a reference to the [`Target`].
    #[must_use]
    pub fn target(&self) -> &dyn Target {
        self.target
    }

    /// Get a mutable reference to the [`Target`].
    pub fn target_mut(&mut self) -> &mut dyn Target {
        self.target
    }

    /// Get a reference to the [`runtime state`](Runtime).
    #[must_use]
    pub fn state(&self) -> &Runtime {
        self.state
    }

    /// Get a mutable reference to the [`runtime state`](Runtime).
    pub fn state_mut(&mut self) -> &mut Runtime {
        self.state
    }

    /// Get a reference to the [`TimeZone`]
    #[must_use]
    pub fn timezone(&self) -> &TimeZone {
        self.timezone
    }
}
